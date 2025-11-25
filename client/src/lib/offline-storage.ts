import { openDB, DBSchema, IDBPDatabase } from 'idb';

interface InventoryDB extends DBSchema {
  counts: {
    key: string; // `${sessionId}-${shopId}-${userId}`
    value: {
      id: string;
      sessionId: string;
      shopId: number;
      userId: string;
      countLines: Array<{
        itemId: number;
        boxes: number;
        singles: number;
      }>;
      lastSaved: number;
      submitted: boolean;
    };
  };
  syncQueue: {
    key: string;
    value: {
      id: string;
      action: 'saveCount' | 'submitCount';
      data: any;
      timestamp: number;
      retryCount: number;
    };
  };
}

class OfflineStorage {
  private db: IDBPDatabase<InventoryDB> | null = null;
  private syncInterval: NodeJS.Timeout | null = null;
  private syncMutex: Map<string, boolean> = new Map(); // Per-session mutex
  private pendingSyncs: Set<string> = new Set(); // Track pending sync operations

  async init(): Promise<void> {
    this.db = await openDB<InventoryDB>('inventory-db', 1, {
      upgrade(db) {
        // Create counts store
        if (!db.objectStoreNames.contains('counts')) {
          db.createObjectStore('counts', { keyPath: 'id' });
        }

        // Create sync queue store
        if (!db.objectStoreNames.contains('syncQueue')) {
          db.createObjectStore('syncQueue', { keyPath: 'id' });
        }
      },
    });

    // Start background sync with proper serialization
    this.startBackgroundSync();
  }

  async saveCountDraft(sessionId: string, shopId: number, userId: string, countLines: any[]): Promise<void> {
    if (!this.db) throw new Error('Database not initialized');
    
    const syncKey = `${sessionId}-${shopId}`;
    const countId = `${sessionId}-${shopId}-${userId}`;
    
    const count = {
      id: countId,
      sessionId,
      shopId,
      userId,
      countLines,
      lastSaved: Date.now(),
      submitted: false,
    };

    await this.db.put('counts', count);

    // Only add to sync queue if not currently syncing this session/shop
    if (!this.syncMutex.get(syncKey)) {
      await this.addToSyncQueue('saveCount', {
        sessionId,
        shopId,
        countLines,
        timestamp: Date.now(),
      });
    }
  }

  async getCountDraft(sessionId: string, shopId: number, userId: string): Promise<any | null> {
    if (!this.db) throw new Error('Database not initialized');

    const countId = `${sessionId}-${shopId}-${userId}`;
    const count = await this.db.get('counts', countId);
    return count || null;
  }

  async submitCount(sessionId: string, shopId: number, userId: string): Promise<void> {
    if (!this.db) throw new Error('Database not initialized');

    const countId = `${sessionId}-${shopId}-${userId}`;
    const count = await this.db.get('counts', countId);
    
    if (count) {
      count.submitted = true;
      await this.db.put('counts', count);

      // Add to sync queue
      await this.addToSyncQueue('submitCount', {
        countId: count.id,
        sessionId,
        shopId,
      });
    }
  }

  private async addToSyncQueue(action: 'saveCount' | 'submitCount', data: any): Promise<void> {
    if (!this.db) return;

    const syncItem = {
      id: `${action}-${Date.now()}-${Math.random()}`,
      action,
      data,
      timestamp: Date.now(),
      retryCount: 0,
    };

    await this.db.add('syncQueue', syncItem);
  }

  private startBackgroundSync(): void {
    if (this.syncInterval) return;

    this.syncInterval = setInterval(async () => {
      await this.processSyncQueue();
    }, 10000); // Sync every 10 seconds for better responsiveness
  }

  async pauseSyncForKey(sessionId: string, shopId: number): Promise<void> {
    const syncKey = `${sessionId}-${shopId}`;
    this.syncMutex.set(syncKey, true);
  }

  async resumeSyncForKey(sessionId: string, shopId: number): Promise<void> {
    const syncKey = `${sessionId}-${shopId}`;
    this.syncMutex.delete(syncKey);
  }

  async forceSyncForKey(sessionId: string, shopId: number): Promise<boolean> {
    const syncKey = `${sessionId}-${shopId}`;
    
    // Skip if already syncing
    if (this.pendingSyncs.has(syncKey)) {
      return false;
    }
    
    this.pendingSyncs.add(syncKey);
    
    try {
      // Get items for this specific session/shop from sync queue
      const syncItems = await this.db?.getAll('syncQueue') || [];
      const relevantItems = syncItems.filter(item => 
        item.data.sessionId === sessionId && item.data.shopId === shopId
      );
      
      if (relevantItems.length === 0) {
        return true;
      }
      
      // Sort by timestamp to process in order
      relevantItems.sort((a, b) => a.timestamp - b.timestamp);
      
      for (const item of relevantItems) {
        try {
          if (item.action === 'saveCount') {
            const response = await fetch('/api/counts', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify(item.data),
              credentials: 'include',
            });
            
            if (!response.ok) {
              throw new Error(`Sync failed: ${response.status}`);
            }
          }
          
          // Remove successfully synced item
          await this.db?.delete('syncQueue', item.id);
        } catch (error) {
          // Increment retry count
          item.retryCount++;
          if (item.retryCount > 3) {
            await this.db?.delete('syncQueue', item.id);
          } else {
            await this.db?.put('syncQueue', item);
          }
          return false;
        }
      }
      
      return true;
    } finally {
      this.pendingSyncs.delete(syncKey);
    }
  }

  private async processSyncQueue(): Promise<void> {
    if (!this.db || !navigator.onLine) return;

    const syncItems = await this.db.getAll('syncQueue');
    
    // Group by session-shop for mutex control
    const itemsByKey = new Map<string, any[]>();
    
    for (const item of syncItems) {
      const syncKey = `${item.data.sessionId}-${item.data.shopId}`;
      if (!itemsByKey.has(syncKey)) {
        itemsByKey.set(syncKey, []);
      }
      itemsByKey.get(syncKey)!.push(item);
    }
    
    // Process each session-shop group with mutex protection
    for (const [syncKey, items] of Array.from(itemsByKey.entries())) {
      if (this.syncMutex.get(syncKey) || this.pendingSyncs.has(syncKey)) {
        continue; // Skip if manual operation in progress
      }
      
      this.pendingSyncs.add(syncKey);
      
      try {
        // Sort by timestamp to maintain order
        items.sort((a: any, b: any) => a.timestamp - b.timestamp);
        
        for (const item of items) {
          try {
            if (item.action === 'saveCount') {
              const response = await fetch('/api/counts', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(item.data),
                credentials: 'include',
              });
              
              if (!response.ok) {
                throw new Error(`Background sync failed: ${response.status}`);
              }
            } else if (item.action === 'submitCount') {
              const response = await fetch(`/api/counts/${item.data.countId}/submit`, {
                method: 'POST',
                credentials: 'include',
              });
              
              if (!response.ok) {
                throw new Error(`Background submit failed: ${response.status}`);
              }
            }

            // Remove from sync queue on success
            await this.db.delete('syncQueue', item.id);
          } catch (error) {
            // Increment retry count
            item.retryCount++;
            
            // Remove after too many retries
            if (item.retryCount > 3) {
              await this.db.delete('syncQueue', item.id);
            } else {
              await this.db.put('syncQueue', item);
            }
            break; // Stop processing this group on error
          }
        }
      } finally {
        this.pendingSyncs.delete(syncKey);
      }
    }
  }

  async clearSyncQueue(): Promise<void> {
    if (!this.db) return;
    await this.db.clear('syncQueue');
  }

  async clearData(): Promise<void> {
    if (!this.db) return;

    await this.db.clear('counts');
    await this.db.clear('syncQueue');
  }

  destroy(): void {
    if (this.syncInterval) {
      clearInterval(this.syncInterval);
      this.syncInterval = null;
    }
    
    if (this.db) {
      this.db.close();
      this.db = null;
    }
  }
}

export const offlineStorage = new OfflineStorage();

// Initialize on module load
if (typeof window !== 'undefined') {
  offlineStorage.init().catch(console.error);
}
