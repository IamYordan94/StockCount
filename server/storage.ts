import { 
  users, shops, items, userShops, shopItems, sessions, counts, countLines, eventLogs,
  costs, movements, varianceThresholds,
  type User, type InsertUser, type Shop, type InsertShop, type Item, type InsertItem,
  type UserShop, type InsertUserShop, type ShopItem, type InsertShopItem,
  type Session, type InsertSession,
  type Count, type InsertCount, type CountLine, type InsertCountLine,
  type EventLog, type InsertEventLog,
  type Cost, type InsertCost, type Movement, type InsertMovement,
  type VarianceThreshold, type InsertVarianceThreshold
} from "@shared/schema";
import { db } from "./db";
import { eq, and, desc, asc, sql, isNotNull, lte } from "drizzle-orm";
import session from "express-session";
import connectPg from "connect-pg-simple";
import type { Store } from "express-session";
import { pool } from "./db";

const PostgresSessionStore = connectPg(session);

export interface IStorage {
  // Users
  getUser(id: string): Promise<User | undefined>;
  getUserByUsername(username: string): Promise<User | undefined>;
  createUser(user: InsertUser): Promise<User>;
  updateUser(id: string, updates: Partial<InsertUser>): Promise<User>;
  deleteUser(id: string): Promise<void>;
  getAllUsers(): Promise<User[]>;
  incrementLoginAttempts(id: string): Promise<void>;
  resetLoginAttempts(id: string): Promise<void>;
  lockUser(id: string, until: Date): Promise<void>;
  
  // Shops
  getAllShops(): Promise<Shop[]>;
  getShop(id: number): Promise<Shop | undefined>;
  createShop(shop: InsertShop): Promise<Shop>;
  updateShop(id: number, updates: Partial<InsertShop>): Promise<Shop>;
  
  // Items
  getAllItems(): Promise<Item[]>;
  getItem(id: number): Promise<Item | undefined>;
  createItem(item: InsertItem): Promise<Item>;
  updateItem(id: number, updates: Partial<InsertItem>): Promise<Item>;
  deleteItem(id: number): Promise<void>;
  
  // User Shop Permissions
  getUserShops(userId: string): Promise<Shop[]>;
  getUserShopIds(userId: string): Promise<number[]>;
  assignUserToShop(userId: string, shopId: number): Promise<UserShop>;
  removeUserFromShop(userId: string, shopId: number): Promise<void>;
  clearUserShopAssignments(userId: string): Promise<void>;
  getUsersForShop(shopId: number): Promise<User[]>;
  
  // Shop Item Management
  getShopItems(shopId: number): Promise<Array<Item & { active: boolean; customName: string | null; packagingUnit: string | null; displayOrder: number | null }>>;
  getAvailableItemsForShop(shopId: number): Promise<Item[]>;
  addItemToShop(shopId: number, itemId: number): Promise<ShopItem>;
  updateShopItem(shopId: number, itemId: number, updates: { active: boolean }): Promise<ShopItem>;
  removeItemFromShop(shopId: number, itemId: number): Promise<void>;
  
  // Sessions
  getActiveSession(): Promise<Session | undefined>;
  getAllSessions(): Promise<Session[]>;
  createSession(session: InsertSession): Promise<Session>;
  closeSession(id: string): Promise<Session>;
  
  // Counts
  getCount(sessionId: string, shopId: number, userId: string): Promise<Count | undefined>;
  getCountForShop(sessionId: string, shopId: number): Promise<Count | undefined>;
  createOrUpdateCount(count: InsertCount): Promise<Count>;
  submitCount(countId: string): Promise<Count>;
  reopenCount(countId: string, reason: string): Promise<Count>;
  getShopProgress(sessionId: string): Promise<Array<{
    shopId: number,
    shopName: string,
    progress: number,
    status: string,
    userName: string | null,
    userId: string | null,
    totalItems: number,
    countedItems: number,
    lastUpdated: Date | null,
    submittedAt: Date | null
  }>>;
  
  // Count Lines
  getCountLines(countId: string): Promise<CountLine[]>;
  upsertCountLine(countLine: InsertCountLine): Promise<CountLine>;
  
  // Event Logs
  logEvent(event: InsertEventLog): Promise<EventLog>;
  getEventLogs(limit?: number): Promise<EventLog[]>;
  
  // Approval Workflow
  getCountById(countId: string): Promise<Count | undefined>;
  approveCount(countId: string, userId: string): Promise<Count>;
  rejectCount(countId: string, userId: string, reason: string): Promise<Count>;
  requestRecountForLine(countId: string, lineId: string, note: string): Promise<CountLine>;
  checkPeriodLocked(shopId: number, periodEnd: Date): Promise<boolean>;
  checkPeriodOverlap(shopId: number, periodStart: Date, periodEnd: Date, excludeCountId?: string): Promise<boolean>;
  
  // Costs
  createCost(cost: InsertCost): Promise<Cost>;
  getCosts(itemId: number): Promise<Cost[]>;
  getEffectiveCost(itemId: number, asOfDate: Date): Promise<Cost | undefined>;
  updateCost(id: string, updates: Partial<InsertCost>): Promise<Cost>;
  deleteCost(id: string): Promise<void>;
  
  // Movements
  createMovement(movement: InsertMovement): Promise<Movement>;
  bulkCreateMovements(movements: InsertMovement[]): Promise<Movement[]>;
  getMovements(shopId: number, itemId?: number, startDate?: Date, endDate?: Date): Promise<Movement[]>;
  
  // Variance Thresholds
  createVarianceThreshold(threshold: InsertVarianceThreshold): Promise<VarianceThreshold>;
  getVarianceThresholds(): Promise<VarianceThreshold[]>;
  updateVarianceThreshold(id: string, updates: Partial<InsertVarianceThreshold>): Promise<VarianceThreshold>;
  deleteVarianceThreshold(id: string): Promise<void>;
  
  // Session store for authentication
  sessionStore: Store;
}

export class DatabaseStorage implements IStorage {
  sessionStore: Store;

  constructor() {
    this.sessionStore = new PostgresSessionStore({ 
      pool, 
      createTableIfMissing: true 
    });
  }

  // Users
  async getUser(id: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.id, id));
    return user || undefined;
  }

  async getUserByUsername(username: string): Promise<User | undefined> {
    const [user] = await db.select().from(users).where(eq(users.username, username));
    return user || undefined;
  }

  async createUser(insertUser: InsertUser): Promise<User> {
    const [user] = await db.insert(users).values(insertUser).returning();
    return user;
  }

  async updateUser(id: string, updates: Partial<InsertUser>): Promise<User> {
    const [user] = await db.update(users).set(updates).where(eq(users.id, id)).returning();
    return user;
  }

  async deleteUser(id: string): Promise<void> {
    await db.delete(users).where(eq(users.id, id));
  }

  async getAllUsers(): Promise<User[]> {
    return await db.select().from(users).orderBy(asc(users.name));
  }

  async incrementLoginAttempts(id: string): Promise<void> {
    await db.update(users)
      .set({ loginAttempts: sql`${users.loginAttempts} + 1` })
      .where(eq(users.id, id));
  }

  async resetLoginAttempts(id: string): Promise<void> {
    await db.update(users)
      .set({ loginAttempts: 0, lockedUntil: null })
      .where(eq(users.id, id));
  }

  async lockUser(id: string, until: Date): Promise<void> {
    await db.update(users)
      .set({ lockedUntil: until })
      .where(eq(users.id, id));
  }

  // Shops
  async getAllShops(): Promise<Shop[]> {
    return await db.select().from(shops).orderBy(asc(shops.id));
  }

  async getShop(id: number): Promise<Shop | undefined> {
    const [shop] = await db.select().from(shops).where(eq(shops.id, id));
    return shop || undefined;
  }

  async createShop(insertShop: InsertShop): Promise<Shop> {
    const [shop] = await db.insert(shops).values(insertShop).returning();
    return shop;
  }

  async updateShop(id: number, updates: Partial<InsertShop>): Promise<Shop> {
    const [shop] = await db.update(shops).set(updates).where(eq(shops.id, id)).returning();
    return shop;
  }

  // Items
  async getAllItems(): Promise<Item[]> {
    return await db.select().from(items).orderBy(asc(items.id));
  }

  async getItem(id: number): Promise<Item | undefined> {
    const [item] = await db.select().from(items).where(eq(items.id, id));
    return item || undefined;
  }

  async createItem(item: InsertItem): Promise<Item> {
    const [newItem] = await db.insert(items).values(item).returning();
    return newItem;
  }

  async updateItem(id: number, updates: Partial<InsertItem>): Promise<Item> {
    const [item] = await db.update(items).set(updates).where(eq(items.id, id)).returning();
    return item;
  }

  async deleteItem(id: number): Promise<void> {
    await db.delete(items).where(eq(items.id, id));
  }

  // User Shop Permissions
  async getUserShops(userId: string): Promise<Shop[]> {
    const result = await db
      .select({ shop: shops })
      .from(userShops)
      .innerJoin(shops, eq(userShops.shopId, shops.id))
      .where(eq(userShops.userId, userId))
      .orderBy(asc(shops.id));
    return result.map(r => r.shop);
  }

  async getUserShopIds(userId: string): Promise<number[]> {
    const result = await db
      .select({ shopId: userShops.shopId })
      .from(userShops)
      .where(eq(userShops.userId, userId))
      .orderBy(asc(userShops.shopId));
    return result.map(r => r.shopId);
  }

  async assignUserToShop(userId: string, shopId: number): Promise<UserShop> {
    const [userShop] = await db.insert(userShops).values({ userId, shopId }).returning();
    return userShop;
  }

  async removeUserFromShop(userId: string, shopId: number): Promise<void> {
    await db.delete(userShops)
      .where(and(eq(userShops.userId, userId), eq(userShops.shopId, shopId)));
  }

  async clearUserShopAssignments(userId: string): Promise<void> {
    await db.delete(userShops).where(eq(userShops.userId, userId));
  }

  async getUsersForShop(shopId: number): Promise<User[]> {
    const result = await db
      .select({ user: users })
      .from(userShops)
      .innerJoin(users, eq(userShops.userId, users.id))
      .where(eq(userShops.shopId, shopId))
      .orderBy(asc(users.name));
    return result.map(r => r.user);
  }

  // Shop Item Management
  async getShopItems(shopId: number): Promise<Array<Item & { active: boolean; customName: string | null; packagingUnit: string | null; displayOrder: number | null }>> {
    const result = await db
      .select({
        id: items.id,
        sku: items.sku,
        defaultName: items.defaultName,
        category: items.category,
        uom: items.uom,
        packSize: items.packSize,
        unitsPerBox: items.unitsPerBox,
        isActive: items.isActive,
        active: shopItems.active,
        customName: shopItems.customName,
        packagingUnit: shopItems.packagingUnit,
        displayOrder: shopItems.displayOrder,
      })
      .from(shopItems)
      .innerJoin(items, eq(shopItems.itemId, items.id))
      .where(eq(shopItems.shopId, shopId))
      .orderBy(
        sql`CASE WHEN ${shopItems.displayOrder} IS NULL THEN 1 ELSE 0 END`,
        asc(shopItems.displayOrder),
        asc(items.category),
        sql`COALESCE(${shopItems.customName}, ${items.defaultName})`
      );
    return result;
  }

  async getAvailableItemsForShop(shopId: number): Promise<Item[]> {
    // Get items that are not yet assigned to this shop using NOT IN with subquery
    const result = await db
      .select()
      .from(items)
      .where(
        sql`${items.id} NOT IN (
          SELECT ${shopItems.itemId} 
          FROM ${shopItems} 
          WHERE ${shopItems.shopId} = ${shopId}
        )`
      )
      .orderBy(asc(items.category), asc(items.defaultName));
    
    return result;
  }

  async addItemToShop(shopId: number, itemId: number): Promise<ShopItem> {
    const [shopItem] = await db.insert(shopItems).values({ shopId, itemId, active: true }).returning();
    return shopItem;
  }

  async updateShopItem(shopId: number, itemId: number, updates: { active: boolean }): Promise<ShopItem> {
    const [shopItem] = await db.update(shopItems)
      .set(updates)
      .where(and(eq(shopItems.shopId, shopId), eq(shopItems.itemId, itemId)))
      .returning();
    return shopItem;
  }

  async removeItemFromShop(shopId: number, itemId: number): Promise<void> {
    await db.delete(shopItems)
      .where(and(eq(shopItems.shopId, shopId), eq(shopItems.itemId, itemId)));
  }

  // Sessions
  async autoCloseExpiredSessions(): Promise<number> {
    // Find all open sessions that have passed their auto-close date
    const now = new Date();
    const expiredSessions = await db.update(sessions)
      .set({ status: 'CLOSED', closedAt: now })
      .where(and(
        eq(sessions.status, 'OPEN'),
        lte(sessions.autoCloseAt, now)
      ))
      .returning();
    
    return expiredSessions.length;
  }

  async getActiveSession(): Promise<Session | undefined> {
    // Auto-close expired sessions before fetching
    await this.autoCloseExpiredSessions();
    
    const [session] = await db.select().from(sessions)
      .where(eq(sessions.status, 'OPEN'))
      .orderBy(desc(sessions.createdAt))
      .limit(1);
    return session || undefined;
  }

  async getAllSessions(): Promise<Session[]> {
    // Auto-close expired sessions before fetching
    await this.autoCloseExpiredSessions();
    
    return await db.select().from(sessions).orderBy(desc(sessions.createdAt));
  }

  async createSession(insertSession: InsertSession): Promise<Session> {
    // Set auto-close date to 3 days from now if not provided
    const threeDaysFromNow = new Date();
    threeDaysFromNow.setDate(threeDaysFromNow.getDate() + 3);
    
    const sessionData = {
      ...insertSession,
      autoCloseAt: insertSession.autoCloseAt || threeDaysFromNow
    };
    
    const [session] = await db.insert(sessions).values(sessionData).returning();
    return session;
  }

  async closeSession(id: string): Promise<Session> {
    const [session] = await db.update(sessions)
      .set({ status: 'CLOSED', closedAt: new Date() })
      .where(eq(sessions.id, id))
      .returning();
    return session;
  }

  // Counts
  async getCount(sessionId: string, shopId: number, userId: string): Promise<Count | undefined> {
    const [count] = await db.select().from(counts)
      .where(and(
        eq(counts.sessionId, sessionId),
        eq(counts.shopId, shopId),
        eq(counts.userId, userId)
      ));
    return count || undefined;
  }

  async getCountForShop(sessionId: string, shopId: number): Promise<Count | undefined> {
    const [count] = await db.select().from(counts)
      .where(and(
        eq(counts.sessionId, sessionId),
        eq(counts.shopId, shopId)
      ))
      .orderBy(desc(counts.updatedAt))
      .limit(1);
    return count || undefined;
  }

  async createOrUpdateCount(insertCount: InsertCount): Promise<Count> {
    const existing = await this.getCount(insertCount.sessionId, insertCount.shopId, insertCount.userId);
    
    if (existing) {
      const [count] = await db.update(counts)
        .set({ ...insertCount, updatedAt: new Date() })
        .where(eq(counts.id, existing.id))
        .returning();
      return count;
    } else {
      const [count] = await db.insert(counts).values(insertCount).returning();
      return count;
    }
  }

  async submitCount(countId: string): Promise<Count> {
    const [count] = await db.update(counts)
      .set({ submittedAt: new Date() })
      .where(eq(counts.id, countId))
      .returning();
    return count;
  }

  async reopenCount(countId: string, reason: string): Promise<Count> {
    const [count] = await db.update(counts)
      .set({ submittedAt: null, reopenReason: reason })
      .where(eq(counts.id, countId))
      .returning();
    return count;
  }

  async getShopProgress(sessionId: string): Promise<Array<{
    shopId: number,
    shopName: string,
    progress: number,
    status: string,
    userName: string | null,
    userId: string | null,
    totalItems: number,
    countedItems: number,
    lastUpdated: Date | null,
    submittedAt: Date | null
  }>> {
    const allShops = await this.getAllShops();
    const sessionCounts = await db.select().from(counts)
      .where(eq(counts.sessionId, sessionId));

    const results = [];
    
    for (const shop of allShops) {
      const shopCount = sessionCounts.find(c => c.shopId === shop.id);
      
      // Always get total items for this shop
      const shopItems = await this.getShopItems(shop.id);
      const totalItems = shopItems.filter(item => item.active).length;
      
      let userName = null;
      let countedItems = 0;
      
      if (shopCount) {
        // Get user name
        const user = await this.getUser(shopCount.userId);
        userName = user?.name || null;
        
        // Get count lines to calculate progress
        const lines = await this.getCountLines(shopCount.id);
        countedItems = lines.filter(line => line.boxes > 0 || line.singles > 0).length;
      }
      
      const progress = totalItems > 0 ? Math.round((countedItems / totalItems) * 100) : 0;
      const status = shopCount?.submittedAt ? 'SUBMITTED' : shopCount ? 'IN_PROGRESS' : 'NOT_STARTED';
      
      results.push({
        shopId: shop.id,
        shopName: shop.name,
        progress,
        status,
        userName,
        userId: shopCount?.userId || null,
        totalItems,
        countedItems,
        lastUpdated: shopCount?.updatedAt || null,
        submittedAt: shopCount?.submittedAt || null
      });
    }
    
    return results;
  }

  // Count Lines
  async getCountLines(countId: string): Promise<CountLine[]> {
    return await db.select().from(countLines)
      .where(eq(countLines.countId, countId))
      .orderBy(asc(countLines.itemId));
  }

  async upsertCountLine(insertCountLine: InsertCountLine): Promise<CountLine> {
    const existing = await db.select().from(countLines)
      .where(and(
        eq(countLines.countId, insertCountLine.countId),
        eq(countLines.itemId, insertCountLine.itemId)
      ))
      .limit(1);

    if (existing.length > 0) {
      const [countLine] = await db.update(countLines)
        .set(insertCountLine)
        .where(eq(countLines.id, existing[0].id))
        .returning();
      return countLine;
    } else {
      const [countLine] = await db.insert(countLines).values(insertCountLine).returning();
      return countLine;
    }
  }

  // Event Logs
  async logEvent(insertEvent: InsertEventLog): Promise<EventLog> {
    const [event] = await db.insert(eventLogs).values(insertEvent).returning();
    return event;
  }

  async getEventLogs(limit = 100): Promise<EventLog[]> {
    return await db.select().from(eventLogs)
      .orderBy(desc(eventLogs.timestamp))
      .limit(limit);
  }

  // Approval Workflow
  async getCountById(countId: string): Promise<Count | undefined> {
    const [count] = await db.select().from(counts).where(eq(counts.id, countId));
    return count || undefined;
  }

  async approveCount(countId: string, userId: string): Promise<Count> {
    const [count] = await db.update(counts)
      .set({
        status: 'APPROVED',
        approvedBy: userId,
        approvedAt: new Date(),
        updatedAt: new Date()
      })
      .where(eq(counts.id, countId))
      .returning();
    return count;
  }

  async rejectCount(countId: string, userId: string, reason: string): Promise<Count> {
    const [count] = await db.update(counts)
      .set({
        status: 'REJECTED',
        approvedBy: userId,
        approvedAt: new Date(),
        rejectionReason: reason,
        updatedAt: new Date()
      })
      .where(eq(counts.id, countId))
      .returning();
    return count;
  }

  async requestRecountForLine(countId: string, lineId: string, note: string): Promise<CountLine> {
    const [line] = await db.update(countLines)
      .set({
        recountRequested: true,
        note: note
      })
      .where(eq(countLines.id, lineId))
      .returning();
    return line;
  }

  async checkPeriodLocked(shopId: number, periodEnd: Date): Promise<boolean> {
    // Check if there's an approved count for the same shop with exact periodEnd match
    // This prevents duplicate approvals for the same period
    const lockedCounts = await db.select().from(counts)
      .where(
        and(
          eq(counts.shopId, shopId),
          eq(counts.status, 'APPROVED'),
          isNotNull(counts.periodEnd),
          sql`${counts.periodEnd} = ${periodEnd}`
        )
      )
      .limit(1);
    return lockedCounts.length > 0;
  }
  
  async checkPeriodOverlap(shopId: number, periodStart: Date, periodEnd: Date, excludeCountId?: string): Promise<boolean> {
    // Check if there's an approved count with overlapping period range
    // Overlap occurs when: newEnd >= existingStart AND newStart <= existingEnd
    const conditions = [
      eq(counts.shopId, shopId),
      eq(counts.status, 'APPROVED'),
      isNotNull(counts.periodStart),
      isNotNull(counts.periodEnd),
      sql`${periodEnd} >= ${counts.periodStart}`,
      sql`${periodStart} <= ${counts.periodEnd}`
    ];
    
    if (excludeCountId) {
      conditions.push(sql`${counts.id}::text != ${excludeCountId}`);
    }
    
    const overlappingCounts = await db.select().from(counts)
      .where(and(...conditions))
      .limit(1);
    return overlappingCounts.length > 0;
  }

  // Costs
  async createCost(insertCost: InsertCost): Promise<Cost> {
    const [cost] = await db.insert(costs).values(insertCost).returning();
    return cost;
  }

  async getCosts(itemId: number): Promise<Cost[]> {
    return await db.select().from(costs)
      .where(eq(costs.itemId, itemId))
      .orderBy(desc(costs.effectiveFrom));
  }

  async getEffectiveCost(itemId: number, asOfDate: Date): Promise<Cost | undefined> {
    const [cost] = await db.select().from(costs)
      .where(
        and(
          eq(costs.itemId, itemId),
          sql`${costs.effectiveFrom} <= ${asOfDate}`
        )
      )
      .orderBy(desc(costs.effectiveFrom))
      .limit(1);
    return cost || undefined;
  }

  async updateCost(id: string, updates: Partial<InsertCost>): Promise<Cost> {
    const [cost] = await db.update(costs)
      .set(updates)
      .where(eq(costs.id, id))
      .returning();
    return cost;
  }

  async deleteCost(id: string): Promise<void> {
    await db.delete(costs).where(eq(costs.id, id));
  }

  // Movements
  async createMovement(insertMovement: InsertMovement): Promise<Movement> {
    const [movement] = await db.insert(movements).values(insertMovement).returning();
    return movement;
  }

  async bulkCreateMovements(insertMovements: InsertMovement[]): Promise<Movement[]> {
    if (insertMovements.length === 0) return [];
    return await db.insert(movements).values(insertMovements).returning();
  }

  async getMovements(
    shopId: number,
    itemId?: number,
    startDate?: Date,
    endDate?: Date
  ): Promise<Movement[]> {
    const conditions = [eq(movements.shopId, shopId)];
    if (itemId !== undefined) {
      conditions.push(eq(movements.itemId, itemId));
    }
    if (startDate) {
      conditions.push(sql`${movements.occurredAt} >= ${startDate}`);
    }
    if (endDate) {
      conditions.push(sql`${movements.occurredAt} <= ${endDate}`);
    }

    return await db.select().from(movements)
      .where(and(...conditions))
      .orderBy(desc(movements.occurredAt));
  }

  // Variance Thresholds
  async createVarianceThreshold(insertThreshold: InsertVarianceThreshold): Promise<VarianceThreshold> {
    const [threshold] = await db.insert(varianceThresholds).values(insertThreshold).returning();
    return threshold;
  }

  async getVarianceThresholds(): Promise<VarianceThreshold[]> {
    return await db.select().from(varianceThresholds)
      .orderBy(desc(varianceThresholds.effectiveFrom));
  }

  async updateVarianceThreshold(id: string, updates: Partial<InsertVarianceThreshold>): Promise<VarianceThreshold> {
    const [threshold] = await db.update(varianceThresholds)
      .set(updates)
      .where(eq(varianceThresholds.id, id))
      .returning();
    return threshold;
  }

  async deleteVarianceThreshold(id: string): Promise<void> {
    await db.delete(varianceThresholds).where(eq(varianceThresholds.id, id));
  }
}

export const storage = new DatabaseStorage();
