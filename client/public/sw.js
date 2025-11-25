const CACHE_NAME = 'stock-intake-v1';
const urlsToCache = [
  '/',
  '/auth',
  '/shops',
  '/admin',
  'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap',
  'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css'
];

// Install event - cache resources
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
      .catch((error) => {
        console.log('Cache addAll failed:', error);
        // Continue anyway - some resources might not be available
        return Promise.resolve();
      })
  );
});

// Fetch event - serve from cache when offline
self.addEventListener('fetch', (event) => {
  // Skip non-GET requests
  if (event.request.method !== 'GET') {
    return;
  }

  // Skip API requests - handle them separately
  if (event.request.url.includes('/api/')) {
    return;
  }

  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        // Return cached version or fetch from network
        if (response) {
          return response;
        }

        return fetch(event.request)
          .then((response) => {
            // Don't cache if not a valid response
            if (!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }

            // Clone the response
            const responseToCache = response.clone();

            caches.open(CACHE_NAME)
              .then((cache) => {
                cache.put(event.request, responseToCache);
              });

            return response;
          });
      })
      .catch(() => {
        // Return offline page for navigation requests
        if (event.request.mode === 'navigate') {
          return caches.match('/');
        }
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Background sync for inventory data
self.addEventListener('sync', (event) => {
  if (event.tag === 'inventory-sync') {
    event.waitUntil(syncInventoryData());
  }
});

// Background sync implementation
async function syncInventoryData() {
  try {
    // Open IndexedDB and get pending sync items
    const db = await openDB();
    const tx = db.transaction(['syncQueue'], 'readonly');
    const store = tx.objectStore('syncQueue');
    const syncItems = await store.getAll();

    for (const item of syncItems) {
      try {
        if (item.action === 'saveCount') {
          await fetch('/api/counts', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(item.data),
            credentials: 'include',
          });
        } else if (item.action === 'submitCount') {
          await fetch(`/api/counts/${item.data.countId}/submit`, {
            method: 'POST',
            credentials: 'include',
          });
        }

        // Remove from sync queue on success
        const deleteTx = db.transaction(['syncQueue'], 'readwrite');
        const deleteStore = deleteTx.objectStore('syncQueue');
        await deleteStore.delete(item.id);
      } catch (error) {
        console.error('Sync failed for item:', item.id, error);
        
        // Increment retry count
        item.retryCount = (item.retryCount || 0) + 1;
        
        // Remove after too many retries
        if (item.retryCount > 5) {
          const deleteTx = db.transaction(['syncQueue'], 'readwrite');
          const deleteStore = deleteTx.objectStore('syncQueue');
          await deleteStore.delete(item.id);
        } else {
          const updateTx = db.transaction(['syncQueue'], 'readwrite');
          const updateStore = updateTx.objectStore('syncQueue');
          await updateStore.put(item);
        }
      }
    }
  } catch (error) {
    console.error('Background sync failed:', error);
  }
}

// Helper function to open IndexedDB (simplified version)
function openDB() {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open('inventory-db', 1);
    
    request.onerror = () => reject(request.error);
    request.onsuccess = () => resolve(request.result);
    
    request.onupgradeneeded = (event) => {
      const db = event.target.result;
      
      if (!db.objectStoreNames.contains('counts')) {
        db.createObjectStore('counts', { keyPath: 'id' });
      }
      
      if (!db.objectStoreNames.contains('syncQueue')) {
        db.createObjectStore('syncQueue', { keyPath: 'id' });
      }
    };
  });
}

// Handle push notifications (for future expansion)
self.addEventListener('push', (event) => {
  const options = {
    body: event.data ? event.data.text() : 'New inventory update available',
    icon: '/manifest-icon-192.maskable.png',
    badge: '/manifest-icon-192.maskable.png',
    data: {
      url: '/'
    }
  };

  event.waitUntil(
    self.registration.showNotification('Stock Intake Platform', options)
  );
});

// Handle notification click
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  event.waitUntil(
    clients.openWindow(event.notification.data.url || '/')
  );
});

// Handle connection changes
self.addEventListener('message', (event) => {
  if (event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

// Network status change handling
self.addEventListener('online', () => {
  console.log('App is back online');
  // Trigger background sync when coming back online
  self.registration.sync.register('inventory-sync')
    .catch(err => console.log('Sync registration failed:', err));
});

self.addEventListener('offline', () => {
  console.log('App went offline');
});
