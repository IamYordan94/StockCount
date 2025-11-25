import type { Express } from "express";
import { setupAuth, hashPassword } from "./auth";
import { storage } from "./storage";
import { insertUserSchema, insertSessionSchema, insertCountLineSchema, insertItemSchema, insertShopItemSchema, counts, costs, movements, countLines } from "@shared/schema";
import { db } from "./db";
import { eq, and, isNotNull, desc, gte, lte, sql, inArray } from "drizzle-orm";
import * as XLSX from 'xlsx';
import { computeVariancesForCount, persistVarianceResults } from "./variance-engine";

function requireAuth(req: any, res: any, next: any) {
  if (!req.isAuthenticated()) {
    return res.status(401).json({ message: "Authentication required" });
  }
  next();
}

function requireRole(roles: string[]) {
  return (req: any, res: any, next: any) => {
    if (!req.user || !roles.includes(req.user.role)) {
      return res.status(403).json({ message: "Insufficient permissions" });
    }
    next();
  };
}

export async function registerRoutes(app: Express): Promise<void> {
  // Setup authentication routes
  setupAuth(app);

  // Initialize default data in background (non-blocking)
  // Database seeding handles this, so this is just a fallback
  initializeDefaultData().catch(err => {
    console.error('Failed to initialize default data:', err);
  });

  // Admin routes
  app.get("/api/admin/users", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const users = await storage.getAllUsers();
      res.json(users);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch users" });
    }
  });

  app.post("/api/admin/users", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const userData = insertUserSchema.parse(req.body);
      const user = await storage.createUser(userData);
      
      // Assign shops if provided
      if (req.body.shopIds && Array.isArray(req.body.shopIds)) {
        for (const shopId of req.body.shopIds) {
          await storage.assignUserToShop(user.id, shopId);
        }
      }

      await storage.logEvent({
        userId: req.user!.id,
        action: 'CREATE_USER',
        payload: JSON.stringify({ targetUserId: user.id, name: user.name })
      });

      res.status(201).json(user);
    } catch (error) {
      res.status(400).json({ message: "Failed to create user" });
    }
  });

  // Get user shop assignments
  app.get("/api/admin/users/:id/shops", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      const shopIds = await storage.getUserShopIds(id);
      res.json({ shopIds });
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch user shop assignments" });
    }
  });

  app.patch("/api/admin/users/:id", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      
      // Validate the update data using a partial schema
      const updateSchema = insertUserSchema.partial();
      const validatedUpdates = updateSchema.parse(req.body);
      
      // Hash password if provided
      if (validatedUpdates.password) {
        validatedUpdates.password = await hashPassword(validatedUpdates.password);
      }
      
      const user = await storage.updateUser(id, validatedUpdates);
      
      // Update shop assignments if provided
      if (req.body.shopIds && Array.isArray(req.body.shopIds)) {
        // Clear existing assignments
        await storage.clearUserShopAssignments(id);
        // Add new assignments
        for (const shopId of req.body.shopIds) {
          await storage.assignUserToShop(id, shopId);
        }
      }
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'UPDATE_USER',
        payload: JSON.stringify({ targetUserId: id, updates: { ...validatedUpdates, password: validatedUpdates.password ? '[REDACTED]' : undefined } })
      });

      res.json(user);
    } catch (error) {
      res.status(400).json({ message: "Failed to update user" });
    }
  });

  app.delete("/api/admin/users/:id", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      
      // Get user to check if it's admin
      const user = await storage.getUser(id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      
      // Prevent deleting admin/owner accounts
      if (user.role === 'OWNER' || user.username === 'admin') {
        return res.status(403).json({ message: "Cannot delete admin accounts" });
      }
      
      await storage.deleteUser(id);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'DELETE_USER',
        payload: JSON.stringify({ targetUserId: id, name: user.name })
      });

      res.json({ message: "User deleted successfully" });
    } catch (error) {
      res.status(400).json({ message: "Failed to delete user" });
    }
  });

  app.post("/api/admin/users/bulk-delete", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { userIds } = req.body;
      
      if (!Array.isArray(userIds) || userIds.length === 0) {
        return res.status(400).json({ message: "Invalid user IDs" });
      }
      
      // Get all users to filter out admin accounts
      const users = await storage.getAllUsers();
      const usersToDelete = users.filter(user => 
        userIds.includes(user.id) && 
        user.role !== 'OWNER' && 
        user.username !== 'admin'
      );
      
      if (usersToDelete.length === 0) {
        return res.status(400).json({ message: "No valid users to delete" });
      }
      
      // Delete each user
      for (const user of usersToDelete) {
        await storage.deleteUser(user.id);
        
        await storage.logEvent({
          userId: req.user!.id,
          action: 'DELETE_USER',
          payload: JSON.stringify({ targetUserId: user.id, name: user.name })
        });
      }

      res.json({ 
        message: `${usersToDelete.length} users deleted successfully`,
        deletedCount: usersToDelete.length
      });
    } catch (error) {
      res.status(400).json({ message: "Failed to delete users" });
    }
  });

  // Shop management
  app.get("/api/shops", requireAuth, async (req, res) => {
    try {
      const shops = await storage.getAllShops();
      res.json(shops);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch shops" });
    }
  });

  app.get("/api/shops/:id", requireAuth, async (req, res) => {
    try {
      const { id } = req.params;
      const shop = await storage.getShop(parseInt(id));
      if (!shop) {
        return res.status(404).json({ message: "Shop not found" });
      }
      res.json(shop);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch shop" });
    }
  });

  app.patch("/api/shops/:id", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      const updates = req.body;
      
      const shop = await storage.updateShop(parseInt(id), updates);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'UPDATE_SHOP',
        payload: JSON.stringify({ shopId: id, updates })
      });

      res.json(shop);
    } catch (error) {
      res.status(400).json({ message: "Failed to update shop" });
    }
  });

  // Shop Item Management
  app.get("/api/shops/:shopId/items", requireAuth, async (req, res) => {
    try {
      const { shopId } = req.params;
      const shopIdNum = parseInt(shopId);
      
      if (isNaN(shopIdNum)) {
        return res.status(400).json({ message: "Invalid shop ID" });
      }
      
      const shopItems = await storage.getShopItems(shopIdNum);
      res.json(shopItems);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch shop items" });
    }
  });

  app.get("/api/shops/:shopId/available-items", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { shopId } = req.params;
      const shopIdNum = parseInt(shopId);
      
      if (isNaN(shopIdNum)) {
        return res.status(400).json({ message: "Invalid shop ID" });
      }
      
      const availableItems = await storage.getAvailableItemsForShop(shopIdNum);
      res.json(availableItems);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch available items" });
    }
  });

  app.post("/api/shops/:shopId/items", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { shopId } = req.params;
      const shopIdNum = parseInt(shopId);
      
      if (isNaN(shopIdNum)) {
        return res.status(400).json({ message: "Invalid shop ID" });
      }
      
      // Validate request body using schema
      const validatedData = insertShopItemSchema.parse({
        shopId: shopIdNum,
        ...req.body
      });
      
      // Check if shop-item relationship already exists
      const existingShopItems = await storage.getShopItems(shopIdNum);
      const alreadyExists = existingShopItems.some(item => item.id === validatedData.itemId);
      
      if (alreadyExists) {
        return res.status(409).json({ message: "Item already assigned to this shop" });
      }
      
      const shopItem = await storage.addItemToShop(shopIdNum, validatedData.itemId);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'ADD_SHOP_ITEM',
        payload: JSON.stringify({ shopId: shopIdNum, itemId: validatedData.itemId })
      });

      res.status(201).json(shopItem);
    } catch (error) {
      if (error instanceof Error && error.name === 'ZodError') {
        return res.status(400).json({ message: "Invalid request data", errors: (error as any).errors });
      }
      res.status(400).json({ message: "Failed to add item to shop" });
    }
  });

  app.patch("/api/shops/:shopId/items/:itemId", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { shopId, itemId } = req.params;
      const shopIdNum = parseInt(shopId);
      const itemIdNum = parseInt(itemId);
      
      if (isNaN(shopIdNum)) {
        return res.status(400).json({ message: "Invalid shop ID" });
      }
      
      if (isNaN(itemIdNum)) {
        return res.status(400).json({ message: "Invalid item ID" });
      }
      
      const { active } = req.body;
      
      if (typeof active !== 'boolean') {
        return res.status(400).json({ message: "active status is required and must be boolean" });
      }
      
      // Check if shop-item relationship exists before updating
      const existingShopItems = await storage.getShopItems(shopIdNum);
      const exists = existingShopItems.some(item => item.id === itemIdNum);
      
      if (!exists) {
        return res.status(404).json({ message: "Shop item relationship not found" });
      }
      
      const shopItem = await storage.updateShopItem(shopIdNum, itemIdNum, { active });
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'UPDATE_SHOP_ITEM',
        payload: JSON.stringify({ shopId: shopIdNum, itemId: itemIdNum, active })
      });

      res.json(shopItem);
    } catch (error) {
      res.status(400).json({ message: "Failed to update shop item" });
    }
  });

  app.delete("/api/shops/:shopId/items/:itemId", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { shopId, itemId } = req.params;
      const shopIdNum = parseInt(shopId);
      const itemIdNum = parseInt(itemId);
      
      if (isNaN(shopIdNum)) {
        return res.status(400).json({ message: "Invalid shop ID" });
      }
      
      if (isNaN(itemIdNum)) {
        return res.status(400).json({ message: "Invalid item ID" });
      }
      
      // Check if shop-item relationship exists before deleting
      const existingShopItems = await storage.getShopItems(shopIdNum);
      const exists = existingShopItems.some(item => item.id === itemIdNum);
      
      if (!exists) {
        return res.status(404).json({ message: "Shop item relationship not found" });
      }
      
      await storage.removeItemFromShop(shopIdNum, itemIdNum);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'REMOVE_SHOP_ITEM',
        payload: JSON.stringify({ shopId: shopIdNum, itemId: itemIdNum })
      });

      res.status(204).send();
    } catch (error) {
      res.status(400).json({ message: "Failed to remove item from shop" });
    }
  });

  // Session management
  app.get("/api/sessions", requireAuth, async (req, res) => {
    try {
      const sessions = await storage.getAllSessions();
      res.json(sessions);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch sessions" });
    }
  });

  app.get("/api/sessions/active", requireAuth, async (req, res) => {
    try {
      const session = await storage.getActiveSession();
      res.json(session);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch active session" });
    }
  });

  app.get("/api/progress/live", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const activeSession = await storage.getActiveSession();
      if (!activeSession) {
        return res.status(404).json({ message: "No active session" });
      }
      
      const progress = await storage.getShopProgress(activeSession.id);
      res.json(progress);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch live progress" });
    }
  });

  app.post("/api/sessions", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const sessionData = insertSessionSchema.parse(req.body);
      const session = await storage.createSession(sessionData);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'CREATE_SESSION',
        payload: JSON.stringify({ sessionId: session.id, name: session.name })
      });

      res.status(201).json(session);
    } catch (error) {
      res.status(400).json({ message: "Failed to create session" });
    }
  });

  app.patch("/api/sessions/:id/close", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      const session = await storage.closeSession(id);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'CLOSE_SESSION',
        payload: JSON.stringify({ sessionId: id })
      });

      res.json(session);
    } catch (error) {
      res.status(400).json({ message: "Failed to close session" });
    }
  });

  app.post("/api/sessions/:id/reopen-counts", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      const { reason } = req.body;
      
      // Get all submitted counts for this session
      const sessionCounts = await db.select().from(counts)
        .where(and(
          eq(counts.sessionId, id),
          isNotNull(counts.submittedAt)
        ));
      
      // Reopen each count with error handling
      let reopenedCount = 0;
      const errors = [];
      
      for (const count of sessionCounts) {
        try {
          await storage.reopenCount(count.id, reason || 'Reopened by admin');
          reopenedCount++;
        } catch (error) {
          errors.push({ countId: count.id, error: String(error) });
        }
      }
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'REOPEN_COUNTS',
        payload: JSON.stringify({ sessionId: id, count: reopenedCount, reason, errors: errors.length })
      });

      if (errors.length > 0 && reopenedCount === 0) {
        return res.status(400).json({ message: "Failed to reopen any counts", errors });
      }

      res.json({ 
        reopenedCount, 
        message: `${reopenedCount} count(s) reopened successfully${errors.length > 0 ? ` (${errors.length} failed)` : ''}`,
        partialFailure: errors.length > 0
      });
    } catch (error) {
      res.status(500).json({ message: "Failed to reopen counts" });
    }
  });

  // Employee routes
  app.get("/api/me/shops", requireAuth, async (req, res) => {
    try {
      const shops = await storage.getUserShops(req.user!.id);
      res.json(shops);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch assigned shops" });
    }
  });

  app.get("/api/items", requireAuth, async (req, res) => {
    try {
      const items = await storage.getAllItems();
      res.json(items);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch items" });
    }
  });

  app.post("/api/items", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const partialData = insertItemSchema.omit({ id: true }).parse(req.body);
      
      // Get next available ID
      const allItems = await storage.getAllItems();
      const maxId = allItems.length > 0 ? Math.max(...allItems.map(item => item.id)) : 0;
      const nextId = maxId + 1;
      
      const itemData = { ...partialData, id: nextId };
      const item = await storage.createItem(itemData);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'CREATE_ITEM',
        payload: JSON.stringify({ itemId: item.id, name: item.defaultName })
      });
      
      res.json(item);
    } catch (error) {
      console.error('Create item error:', error);
      res.status(400).json({ message: "Failed to create item" });
    }
  });

  app.put("/api/items/:id", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      const updates = insertItemSchema.partial().parse(req.body);
      const item = await storage.updateItem(parseInt(id), updates);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'UPDATE_ITEM',
        payload: JSON.stringify({ itemId: id, updates })
      });
      
      res.json(item);
    } catch (error) {
      res.status(400).json({ message: "Failed to update item" });
    }
  });

  app.delete("/api/items/:id", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      await storage.deleteItem(parseInt(id));
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'DELETE_ITEM',
        payload: JSON.stringify({ itemId: id })
      });
      
      res.json({ message: "Item deleted successfully" });
    } catch (error) {
      res.status(400).json({ message: "Failed to delete item" });
    }
  });

  // Counting routes
  app.get("/api/counts", requireAuth, async (req, res) => {
    try {
      const { sessionId, shopId } = req.query;
      if (!sessionId || !shopId) {
        return res.status(400).json({ message: "sessionId and shopId are required" });
      }

      const count = await storage.getCount(sessionId as string, parseInt(shopId as string), req.user!.id);
      if (!count) {
        return res.status(404).json({ message: "Count not found" });
      }

      const countLines = await storage.getCountLines(count.id);
      res.json({ count, countLines });
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch count" });
    }
  });

  app.get("/api/counts/:id", requireAuth, async (req, res) => {
    try {
      const { id } = req.params;
      
      // Get the count
      const count = await storage.getCountById(id);
      if (!count) {
        return res.status(404).json({ message: "Count not found" });
      }
      
      // Check role-based and location-based access control
      const userShopIds = await storage.getUserShopIds(req.user!.id);
      
      // Only OWNER role has unrestricted access to all shops
      // All other roles (SUPERVISOR, EMPLOYEE) must have shop assignment
      if (req.user!.role !== 'OWNER' && !userShopIds.includes(count.shopId)) {
        return res.status(403).json({ message: "You don't have access to this count" });
      }
      
      // Cost visibility: Hidden from EMPLOYEE role
      const includeCosts = ['OWNER', 'SUPERVISOR'].includes(req.user!.role);
      
      // Get count lines with variance data
      const countLines = await storage.getCountLines(id);
      
      // Batch-fetch all items to avoid N+1 query problem
      const allItems = await storage.getAllItems();
      const itemsMap = new Map(allItems.map(item => [item.id, item]));
      
      // Enrich count lines with item details
      const enrichedLines = countLines.map((line) => {
        const item = itemsMap.get(line.itemId);
        return {
          ...line,
          item: item ? {
            id: item.id,
            name: item.defaultName,
            sku: item.sku,
            category: item.category,
            uom: item.uom,
            packSize: item.packSize
          } : null,
          // Include variance data if available
          expectedQty: line.expectedQty,
          varianceQty: line.varianceQty,
          varianceCost: includeCosts ? line.varianceCost : null,
          varianceSeverity: line.varianceSeverity,
          note: line.note
        };
      });
      
      // Get shop details
      const shop = await storage.getShop(count.shopId);
      
      // Get submitter and approver user details if applicable
      let submittedByUser = null;
      let approvedByUser = null;
      
      if (count.submittedBy) {
        submittedByUser = await storage.getUser(count.submittedBy);
      }
      if (count.approvedBy) {
        approvedByUser = await storage.getUser(count.approvedBy);
      }
      
      // Calculate if user can approve this count
      const hasShopAccess = req.user!.role === 'OWNER' || userShopIds.includes(count.shopId);
      const canApproveRole = ['OWNER', 'SUPERVISOR'].includes(req.user!.role);
      const isNotSelfApproval = !(req.user!.role === 'SUPERVISOR' && count.submittedBy === req.user!.id);
      const userCanApprove = canApproveRole && 
                            count.status === 'SUBMITTED' && 
                            hasShopAccess &&
                            isNotSelfApproval;
      
      res.json({
        count: {
          ...count,
          shop: shop ? { id: shop.id, name: shop.name } : null,
          submittedByUser: submittedByUser ? { id: submittedByUser.id, username: submittedByUser.username } : null,
          approvedByUser: approvedByUser ? { id: approvedByUser.id, username: approvedByUser.username } : null
        },
        countLines: enrichedLines,
        userCanApprove
      });
    } catch (error) {
      console.error('Get count error:', error);
      res.status(500).json({ message: "Failed to fetch count" });
    }
  });

  // List counts with status filter for approvals page
  app.get("/api/counts/list", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { status } = req.query;
      const user = req.user!;

      // Determine accessible shop IDs based on role
      let shopIdsToQuery: number[] = [];
      if (user.role === 'OWNER') {
        const allShops = await storage.getAllShops();
        shopIdsToQuery = allShops.map(s => s.id);
      } else if (user.role === 'SUPERVISOR') {
        shopIdsToQuery = await storage.getUserShopIds(user.id);
      }

      // Query counts with status filter
      const countsQuery = await db
        .select()
        .from(counts)
        .where(
          and(
            shopIdsToQuery.length > 0 ? inArray(counts.shopId, shopIdsToQuery) : sql`1=0`,
            status ? eq(counts.status, status as string) : undefined
          )
        )
        .orderBy(desc(counts.submittedAt));

      // Fetch additional data
      const allShops = await storage.getAllShops();
      const allUsers = await storage.getAllUsers();
      const allItems = await storage.getAllItems();
      const shopsMap = new Map(allShops.map(shop => [shop.id, shop]));
      const usersMap = new Map(allUsers.map(user => [user.id, user]));
      const itemsMap = new Map(allItems.map(item => [item.id, item]));

      // Enrich counts with lines and details
      const enrichedCounts = await Promise.all(
        countsQuery.map(async (count) => {
          const countLines = await storage.getCountLines(count.id);
          const shop = shopsMap.get(count.shopId);
          const countUser = usersMap.get(count.userId);

          const enrichedLines = countLines.map((line) => {
            const item = itemsMap.get(line.itemId);
            return {
              id: line.id,
              itemId: line.itemId,
              itemName: item?.defaultName || '',
              itemSku: item?.sku || '',
              category: item?.category || '',
              boxes: line.boxes,
              singles: line.singles,
              note: line.note,
              expectedQty: line.expectedQty ? parseFloat(line.expectedQty) : null,
              varianceQty: line.varianceQty ? parseFloat(line.varianceQty) : null,
              varianceCost: line.varianceCost ? parseFloat(line.varianceCost) : null,
              varianceSeverity: line.varianceSeverity
            };
          });

          return {
            id: count.id,
            shopId: count.shopId,
            shopName: shop?.name || '',
            userId: count.userId,
            userName: countUser?.name || '',
            status: count.status,
            periodStart: count.periodStart,
            periodEnd: count.periodEnd,
            createdAt: count.createdAt,
            submittedAt: count.submittedAt,
            approvedAt: count.approvedAt,
            approvedBy: count.approvedBy,
            rejectedReason: count.rejectedReason,
            lines: enrichedLines
          };
        })
      );

      res.json(enrichedCounts);
    } catch (error) {
      console.error('List counts error:', error);
      res.status(500).json({ message: "Failed to fetch counts" });
    }
  });

  app.post("/api/counts", requireAuth, async (req, res) => {
    try {
      const { sessionId, shopId, countLines } = req.body;
      console.log('POST /api/counts received:', { sessionId, shopId, countLines: countLines?.length || 0 });
      
      // Create or update count
      const count = await storage.createOrUpdateCount({
        sessionId,
        shopId: parseInt(shopId),
        userId: req.user!.id
      });
      console.log('Count created/updated:', count.id);

      // Update count lines
      if (countLines && Array.isArray(countLines)) {
        console.log('Processing count lines:', countLines.filter(line => line.boxes > 0 || line.singles > 0));
        for (const line of countLines) {
          const countLineData = insertCountLineSchema.parse({
            ...line,
            countId: count.id
          });
          console.log('Upserting count line:', countLineData);
          await storage.upsertCountLine(countLineData);
        }
      }

      res.json(count);
    } catch (error) {
      console.error('Save count error:', error);
      res.status(400).json({ message: "Failed to save count" });
    }
  });

  app.post("/api/counts/:id/submit", requireAuth, async (req, res) => {
    try {
      const { id } = req.params;
      const { periodStart, periodEnd } = req.body;
      
      // Get the count
      const count = await storage.getCountById(id);
      if (!count) {
        return res.status(404).json({ message: "Count not found" });
      }
      
      // Check for overlapping periods
      if (periodStart && periodEnd) {
        const hasOverlap = await storage.checkPeriodOverlap(
          count.shopId, 
          new Date(periodStart), 
          new Date(periodEnd),
          id // exclude this count
        );
        if (hasOverlap) {
          return res.status(409).json({ 
            message: "Period overlaps with an existing approved count. Please choose a different date range.",
            code: "PERIOD_OVERLAP"
          });
        }
      }
      
      // Submit the count with period dates
      const submittedCount = await storage.submitCount(id);
      
      // Update period dates and submitted_by
      const updatedCount = await db.update(counts)
        .set({
          periodStart: periodStart ? new Date(periodStart) : null,
          periodEnd: periodEnd ? new Date(periodEnd) : null,
          submittedBy: req.user!.id,
          updatedAt: new Date()
        })
        .where(eq(counts.id, id))
        .returning();
      
      // Get count lines and compute variances if period is defined
      if (periodStart && periodEnd) {
        const countLines = await storage.getCountLines(id);
        const variances = await computeVariancesForCount(
          id,
          count.shopId,
          new Date(periodStart),
          new Date(periodEnd),
          countLines.map(line => ({
            itemId: line.itemId,
            boxes: line.boxes,
            singles: line.singles
          }))
        );
        await persistVarianceResults(id, variances);
      }
      
      // Audit logging with before/after state
      await storage.logEvent({
        userId: req.user!.id,
        action: 'SUBMIT_COUNT',
        entityType: 'COUNT',
        entityId: id,
        payload: JSON.stringify({ countId: id, shopId: count.shopId, periodStart, periodEnd }),
        beforeJson: JSON.stringify({ status: count.status, periodStart: count.periodStart, periodEnd: count.periodEnd }),
        afterJson: JSON.stringify({ status: 'SUBMITTED', periodStart, periodEnd, submittedBy: req.user!.id })
      });

      res.json(updatedCount[0]);
    } catch (error) {
      console.error('Submit count error:', error);
      res.status(400).json({ message: "Failed to submit count" });
    }
  });

  // Approval workflow endpoints
  app.post("/api/counts/:id/approve", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      
      // Get the count
      const count = await storage.getCountById(id);
      if (!count) {
        return res.status(404).json({ message: "Count not found" });
      }
      
      // Check if count is in SUBMITTED status
      if (count.status !== 'SUBMITTED') {
        return res.status(400).json({ message: "Can only approve submitted counts" });
      }
      
      // Prevent self-approval for supervisors
      if (req.user!.role === 'SUPERVISOR' && count.submittedBy === req.user!.id) {
        return res.status(403).json({ 
          message: "Supervisors cannot approve their own submissions",
          code: "SELF_APPROVAL_FORBIDDEN"
        });
      }
      
      // Check for overlapping periods with existing approved counts
      if (count.periodStart && count.periodEnd) {
        const hasOverlap = await storage.checkPeriodOverlap(
          count.shopId, 
          count.periodStart, 
          count.periodEnd,
          id // exclude this count
        );
        if (hasOverlap) {
          return res.status(409).json({ 
            message: "Period overlaps with another approved count. Please adjust the date range.",
            code: "PERIOD_OVERLAP"
          });
        }
      }
      
      // Approve the count
      const approvedCount = await storage.approveCount(id, req.user!.id);
      
      // Audit logging with before/after state
      await storage.logEvent({
        userId: req.user!.id,
        action: 'APPROVE_COUNT',
        entityType: 'COUNT',
        entityId: id,
        payload: JSON.stringify({ 
          countId: id, 
          shopId: count.shopId,
          submittedBy: count.submittedBy
        }),
        beforeJson: JSON.stringify({ status: count.status, approvedBy: count.approvedBy, approvedAt: count.approvedAt }),
        afterJson: JSON.stringify({ status: 'APPROVED', approvedBy: req.user!.id, approvedAt: new Date() })
      });

      res.json(approvedCount);
    } catch (error) {
      console.error('Approve count error:', error);
      res.status(400).json({ message: "Failed to approve count" });
    }
  });

  app.post("/api/counts/:id/reject", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      const { reason } = req.body;
      
      if (!reason || reason.trim().length === 0) {
        return res.status(400).json({ message: "Rejection reason is required" });
      }
      
      // Get the count
      const count = await storage.getCountById(id);
      if (!count) {
        return res.status(404).json({ message: "Count not found" });
      }
      
      // Check if count is in SUBMITTED status
      if (count.status !== 'SUBMITTED') {
        return res.status(400).json({ message: "Can only reject submitted counts" });
      }
      
      // Reject the count
      const rejectedCount = await storage.rejectCount(id, req.user!.id, reason);
      
      // Audit logging with before/after state
      await storage.logEvent({
        userId: req.user!.id,
        action: 'REJECT_COUNT',
        entityType: 'COUNT',
        entityId: id,
        payload: JSON.stringify({ 
          countId: id, 
          shopId: count.shopId,
          reason,
          submittedBy: count.submittedBy
        }),
        beforeJson: JSON.stringify({ status: count.status }),
        afterJson: JSON.stringify({ status: 'REJECTED', rejectionReason: reason })
      });

      res.json(rejectedCount);
    } catch (error) {
      console.error('Reject count error:', error);
      res.status(400).json({ message: "Failed to reject count" });
    }
  });

  app.post("/api/counts/:id/lines/:lineId/recount", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id, lineId } = req.params;
      const { note } = req.body;
      
      // Get the count
      const count = await storage.getCountById(id);
      if (!count) {
        return res.status(404).json({ message: "Count not found" });
      }
      
      // Request recount for the line
      const countLine = await storage.requestRecountForLine(id, lineId, note || "Recount requested");
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'REQUEST_RECOUNT',
        payload: JSON.stringify({ 
          countId: id, 
          lineId,
          itemId: countLine.itemId,
          note
        })
      });

      res.json(countLine);
    } catch (error) {
      console.error('Request recount error:', error);
      res.status(400).json({ message: "Failed to request recount" });
    }
  });

  // Progress tracking
  app.get("/api/progress", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { sessionId } = req.query;
      if (!sessionId) {
        return res.status(400).json({ message: "sessionId is required" });
      }

      const progress = await storage.getShopProgress(sessionId as string);
      res.json(progress);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch progress" });
    }
  });

  // Export routes
  app.get("/api/exports/shops/:shopId", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { shopId } = req.params;
      let { sessionId } = req.query;
      
      if (!sessionId) {
        return res.status(400).json({ message: "sessionId is required" });
      }

      // Get count data for the shop (from any user)
      let count = await storage.getCountForShop(sessionId as string, parseInt(shopId));
      
      // If no count found in the specified session, try to find the most recent count for this shop from any session
      if (!count) {
        const [recentCount] = await db.select().from(counts)
          .where(eq(counts.shopId, parseInt(shopId)))
          .orderBy(desc(counts.updatedAt))
          .limit(1);
        count = recentCount;
        if (count) {
          sessionId = count.sessionId;
        }
      }
      
      if (!count) {
        return res.status(404).json({ message: "No count found for this shop" });
      }

      const shop = await storage.getShop(parseInt(shopId));
      
      // Get all active shop items (these are already full Item objects with active flag)
      const shopItems = await storage.getShopItems(parseInt(shopId));
      const activeItems = shopItems.filter(si => si.active);
      
      // Get count lines
      const countLines = await storage.getCountLines(count.id);

      // Create Excel workbook
      const workbook = XLSX.utils.book_new();
      
      // Check if this is Rijksmuseum shop (ID 2) for custom formatting
      const isRijksmuseum = parseInt(shopId) === 2;
      
      if (isRijksmuseum) {
        // Rijksmuseum custom format: group by category with headers
        const categoryOrder = ['ICECREAM', 'DRINK', 'FOOD', 'STROMMA'];
        const categoryHeaders: Record<string, string> = {
          'ICECREAM': 'IJSJES',
          'DRINK': 'DRANK',
          'FOOD': 'SNACKS',
          'STROMMA': 'STROMMA BRANDED'
        };
        
        const data: any[] = [];
        
        categoryOrder.forEach(category => {
          const categoryItems = activeItems
            .filter(item => item.category === category)
            .sort((a, b) => {
              // Sort by displayOrder (nulls last), then by name for tie-breaking
              if (a.displayOrder === null && b.displayOrder === null) {
                return (a.customName || a.defaultName || '').localeCompare(b.customName || b.defaultName || '');
              }
              if (a.displayOrder === null) return 1;
              if (b.displayOrder === null) return -1;
              
              // If displayOrder is equal, use name as tie-breaker
              if (a.displayOrder === b.displayOrder) {
                return (a.customName || a.defaultName || '').localeCompare(b.customName || b.defaultName || '');
              }
              return a.displayOrder - b.displayOrder;
            });
          
          if (categoryItems.length === 0) return;
          
          // Add category header row
          data.push({
            'Productinformatie': categoryHeaders[category],
            'Verpakkings eenheid': '',
            'Aantal': '',
            'Losse stuks': ''
          });
          
          // Add items for this category
          categoryItems.forEach(item => {
            const countLine = countLines.find(cl => cl.itemId === item.id);
            const itemName = item.customName || item.defaultName;
            const packagingUnit = item.packagingUnit || '';
            
            data.push({
              'Productinformatie': itemName,
              'Verpakkings eenheid': packagingUnit,
              'Aantal': countLine?.boxes || '',
              'Losse stuks': countLine?.singles || ''
            });
          });
        });
        
        const worksheet = XLSX.utils.json_to_sheet(data);
        XLSX.utils.book_append_sheet(workbook, worksheet, shop?.name || `Shop ${shopId}`);
      } else {
        // Standard format for other shops
        const data = activeItems.map(item => {
          const countLine = countLines.find(cl => cl.itemId === item.id);
          
          const boxes = countLine?.boxes || 0;
          const singles = countLine?.singles || 0;
          const unitsPerBox = item.unitsPerBox || 1;
          const totalUnits = (boxes * unitsPerBox) + singles;
          
          return {
            'Item Name': item.defaultName || `Item ${item.id}`,
            'Category': item.category || '',
            'Boxes': boxes,
            'Singles': singles,
            'Units per Box': unitsPerBox,
            'Total Units': totalUnits
          };
        });

        const worksheet = XLSX.utils.json_to_sheet(data);
        XLSX.utils.book_append_sheet(workbook, worksheet, shop?.name || `Shop ${shopId}`);
      }

      const buffer = XLSX.write(workbook, { type: 'buffer', bookType: 'xlsx' });
      
      res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.setHeader('Content-Disposition', `attachment; filename="Shop_${shopId}_Inventory.xlsx"`);
      res.send(buffer);
    } catch (error) {
      res.status(500).json({ message: "Failed to generate export" });
    }
  });

  // Cost Management endpoints (Admin only)
  app.post("/api/costs", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { itemId, costPerUom, currency, effectiveFrom } = req.body;
      
      if (!itemId || !costPerUom) {
        return res.status(400).json({ message: "itemId and costPerUom are required" });
      }
      
      const cost = await storage.createCost({
        itemId,
        costPerUom: costPerUom.toString(),
        currency: currency || 'EUR',
        effectiveFrom: effectiveFrom ? new Date(effectiveFrom) : new Date()
      });
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'CREATE_COST',
        payload: JSON.stringify({ itemId, costPerUom, effectiveFrom }),
        entityType: 'cost',
        entityId: cost.id,
        afterJson: JSON.stringify(cost)
      });
      
      res.json(cost);
    } catch (error) {
      console.error('Create cost error:', error);
      res.status(400).json({ message: "Failed to create cost" });
    }
  });

  app.get("/api/costs", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { itemId } = req.query;
      
      if (!itemId) {
        return res.status(400).json({ message: "itemId is required" });
      }
      
      const costs = await storage.getCosts(parseInt(itemId as string));
      res.json(costs);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch costs" });
    }
  });

  app.put("/api/costs/:id", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      const updates = req.body;
      
      const oldCost = await db.select().from(costs).where(eq(costs.id, id)).limit(1);
      const cost = await storage.updateCost(id, updates);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'UPDATE_COST',
        payload: JSON.stringify({ id, updates }),
        entityType: 'cost',
        entityId: id,
        beforeJson: oldCost.length > 0 ? JSON.stringify(oldCost[0]) : null,
        afterJson: JSON.stringify(cost)
      });
      
      res.json(cost);
    } catch (error) {
      res.status(400).json({ message: "Failed to update cost" });
    }
  });

  app.delete("/api/costs/:id", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { id } = req.params;
      
      const oldCost = await db.select().from(costs).where(eq(costs.id, id)).limit(1);
      await storage.deleteCost(id);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'DELETE_COST',
        payload: JSON.stringify({ id }),
        entityType: 'cost',
        entityId: id,
        beforeJson: oldCost.length > 0 ? JSON.stringify(oldCost[0]) : null
      });
      
      res.json({ message: "Cost deleted successfully" });
    } catch (error) {
      res.status(400).json({ message: "Failed to delete cost" });
    }
  });

  // Movements tracking endpoint
  app.post("/api/movements/sync", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { movements: movementData } = req.body;
      
      if (!Array.isArray(movementData) || movementData.length === 0) {
        return res.status(400).json({ message: "movements array is required" });
      }
      
      // Validate and convert movements
      const validMovements = movementData.map((m: any) => ({
        shopId: m.shopId,
        itemId: m.itemId,
        type: m.type,
        quantity: m.quantity.toString(),
        sourceRef: m.sourceRef || null,
        occurredAt: m.occurredAt ? new Date(m.occurredAt) : new Date()
      }));
      
      const created = await storage.bulkCreateMovements(validMovements);
      
      await storage.logEvent({
        userId: req.user!.id,
        action: 'BULK_CREATE_MOVEMENTS',
        payload: JSON.stringify({ count: created.length }),
        entityType: 'movements',
        entityId: 'bulk',
        afterJson: JSON.stringify({ count: created.length, movements: created.map(m => m.id) })
      });
      
      res.json({ 
        message: `Successfully synced ${created.length} movements`,
        movements: created 
      });
    } catch (error) {
      console.error('Sync movements error:', error);
      res.status(400).json({ message: "Failed to sync movements" });
    }
  });

  app.get("/api/movements", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { shopId, itemId, startDate, endDate } = req.query;
      
      if (!shopId) {
        return res.status(400).json({ message: "shopId is required" });
      }
      
      const movements = await storage.getMovements(
        parseInt(shopId as string),
        itemId ? parseInt(itemId as string) : undefined,
        startDate ? new Date(startDate as string) : undefined,
        endDate ? new Date(endDate as string) : undefined
      );
      
      res.json(movements);
    } catch (error) {
      res.status(500).json({ message: "Failed to fetch movements" });
    }
  });

  // Variance reporting endpoint
  app.get("/api/reports/variance", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { startDate, endDate, shopId } = req.query;
      
      // Get user's assigned shops for permission filtering
      const userShopIds = await storage.getUserShopIds(req.user!.id);
      
      // Build list of shops to query
      let shopIdsToQuery: number[] = [];
      
      if (shopId) {
        // Specific shop requested - validate it's a number
        const requestedShopId = parseInt(shopId as string);
        if (isNaN(requestedShopId)) {
          return res.status(400).json({ message: "Invalid shopId parameter" });
        }
        
        // Check if user has access to this shop
        if (req.user!.role !== 'OWNER' && !userShopIds.includes(requestedShopId)) {
          return res.status(403).json({ message: "You don't have access to this shop" });
        }
        
        shopIdsToQuery = [requestedShopId];
      } else {
        // No specific shop - query all accessible shops
        if (req.user!.role === 'OWNER') {
          // Owners can see all shops
          const allShops = await storage.getAllShops();
          shopIdsToQuery = allShops.map(shop => shop.id);
        } else {
          // Non-owners see only assigned shops
          shopIdsToQuery = userShopIds;
        }
      }
      
      // Short-circuit if user has no accessible shops
      if (shopIdsToQuery.length === 0) {
        return res.json({
          summary: {
            totalCounts: 0,
            totalVarianceLines: 0,
            criticalVariances: 0,
            warnVariances: 0,
            infoVariances: 0,
            totalVarianceCost: 0
          },
          variances: [],
          dateRange: {
            start: startDate ? new Date(startDate as string) : new Date(new Date().setDate(new Date().getDate() - 30)),
            end: endDate ? new Date(endDate as string) : new Date()
          },
          shops: []
        });
      }
      
      // Build date range filter with normalized boundaries
      let start: Date;
      let end: Date;
      
      if (startDate) {
        start = new Date(startDate as string);
      } else {
        // Default to 30 days ago
        start = new Date();
        start.setDate(start.getDate() - 30);
      }
      // Normalize to start of day
      start.setHours(0, 0, 0, 0);
      
      if (endDate) {
        end = new Date(endDate as string);
      } else {
        // Default to today
        end = new Date();
      }
      // Normalize to end of day
      end.setHours(23, 59, 59, 999);
      
      // Query approved counts within date range for accessible shops
      const approvedCounts = await db
        .select()
        .from(counts)
        .where(
          and(
            eq(counts.status, 'APPROVED'),
            gte(counts.createdAt, start),
            lte(counts.createdAt, end),
            inArray(counts.shopId, shopIdsToQuery)
          )
        )
        .orderBy(desc(counts.createdAt));
      
      // Fetch count lines with variance data for these counts
      const countIds = approvedCounts.map(c => c.id);
      
      // Short-circuit if no approved counts found
      if (countIds.length === 0) {
        const allShops = await storage.getAllShops();
        const shopsMap = new Map(allShops.map(shop => [shop.id, shop]));
        
        return res.json({
          summary: {
            totalCounts: 0,
            totalVarianceLines: 0,
            criticalVariances: 0,
            warnVariances: 0,
            infoVariances: 0,
            totalVarianceCost: 0
          },
          variances: [],
          dateRange: { start, end },
          shops: shopIdsToQuery.map(id => {
            const shop = shopsMap.get(id);
            return { id, name: shop?.name || `Shop ${id}` };
          })
        });
      }
      
      const varianceLines = await db
        .select()
        .from(countLines)
        .where(
          and(
            inArray(countLines.countId, countIds),
            isNotNull(countLines.varianceSeverity)
          )
        );
      
      // Enrich with item and shop details
      const allItems = await storage.getAllItems();
      const allShops = await storage.getAllShops();
      const itemsMap = new Map(allItems.map(item => [item.id, item]));
      const shopsMap = new Map(allShops.map(shop => [shop.id, shop]));
      const countsMap = new Map(approvedCounts.map(count => [count.id, count]));
      
      // Calculate summary statistics
      const summary = {
        totalCounts: approvedCounts.length,
        totalVarianceLines: varianceLines.length,
        criticalVariances: varianceLines.filter(l => l.varianceSeverity === 'CRITICAL').length,
        warnVariances: varianceLines.filter(l => l.varianceSeverity === 'WARN').length,
        infoVariances: varianceLines.filter(l => l.varianceSeverity === 'INFO').length,
        totalVarianceCost: varianceLines.reduce((sum, l) => sum + (parseFloat(l.varianceCost || '0')), 0)
      };
      
      // Build detailed variance records
      const detailedVariances = varianceLines.map(line => {
        const count = countsMap.get(line.countId);
        const item = itemsMap.get(line.itemId);
        const shop = count ? shopsMap.get(count.shopId) : null;
        
        // Calculate counted quantity from boxes and singles
        const unitsPerBox = item?.unitsPerBox || 1;
        const countedQty = line.boxes + (line.singles / unitsPerBox);
        
        return {
          id: line.id,
          countId: line.countId,
          shopId: count?.shopId,
          shopName: shop?.name,
          itemId: line.itemId,
          itemName: item?.defaultName,
          itemSku: item?.sku,
          boxes: line.boxes,
          singles: line.singles,
          countedQty,
          expectedQty: line.expectedQty ? parseFloat(line.expectedQty) : null,
          varianceQty: line.varianceQty ? parseFloat(line.varianceQty) : null,
          varianceCost: line.varianceCost ? parseFloat(line.varianceCost) : null,
          varianceSeverity: line.varianceSeverity,
          note: line.note,
          createdAt: count?.createdAt,
          periodStart: count?.periodStart,
          periodEnd: count?.periodEnd
        };
      });
      
      // Sort by severity and variance cost
      detailedVariances.sort((a, b) => {
        const severityOrder = { 'CRITICAL': 0, 'WARN': 1, 'INFO': 2 };
        const severityDiff = severityOrder[a.varianceSeverity as keyof typeof severityOrder] - 
                             severityOrder[b.varianceSeverity as keyof typeof severityOrder];
        if (severityDiff !== 0) return severityDiff;
        return Math.abs(b.varianceCost || 0) - Math.abs(a.varianceCost || 0);
      });
      
      res.json({
        summary,
        variances: detailedVariances,
        dateRange: {
          start,
          end
        },
        shops: shopIdsToQuery.map(id => {
          const shop = shopsMap.get(id);
          return { id, name: shop?.name || `Shop ${id}` };
        })
      });
    } catch (error) {
      console.error('Variance report error:', error);
      res.status(500).json({ message: "Failed to generate variance report" });
    }
  });

  // Consolidated Excel export endpoint
  app.get("/api/exports/consolidated.xlsx", requireAuth, requireRole(['OWNER', 'SUPERVISOR']), async (req, res) => {
    try {
      const { startDate, endDate, shopId } = req.query;
      const user = req.user!;

      // Determine accessible shop IDs based on role
      let shopIdsToQuery: number[] = [];
      if (user.role === 'OWNER') {
        const allShops = await storage.getAllShops();
        shopIdsToQuery = allShops.map(s => s.id);
      } else if (user.role === 'SUPERVISOR') {
        shopIdsToQuery = await storage.getUserShopIds(user.id);
      }

      // Apply shop filter if provided
      if (shopId) {
        const requestedShopId = parseInt(shopId as string, 10);
        if (isNaN(requestedShopId)) {
          return res.status(400).json({ message: "Invalid shopId parameter" });
        }
        if (shopIdsToQuery.includes(requestedShopId)) {
          shopIdsToQuery = [requestedShopId];
        } else {
          shopIdsToQuery = [];
        }
      }

      // Build date range filter with normalized boundaries
      let start: Date;
      let end: Date;
      
      if (startDate) {
        start = new Date(startDate as string);
      } else {
        start = new Date();
        start.setDate(start.getDate() - 30);
      }
      start.setHours(0, 0, 0, 0);
      
      if (endDate) {
        end = new Date(endDate as string);
      } else {
        end = new Date();
      }
      end.setHours(23, 59, 59, 999);

      // Fetch all necessary data
      const allItems = await storage.getAllItems();
      const allShops = await storage.getAllShops();
      const itemsMap = new Map(allItems.map(item => [item.id, item]));
      const shopsMap = new Map(allShops.map(shop => [shop.id, shop]));

      // Sheet 1: Inventory Snapshot - Latest approved count per shop/item
      const snapshotQuery = shopIdsToQuery.length > 0
        ? await db
            .select()
            .from(counts)
            .where(
              and(
                inArray(counts.shopId, shopIdsToQuery),
                eq(counts.status, 'APPROVED'),
                gte(counts.approvedAt, start),
                lte(counts.approvedAt, end)
              )
            )
            .orderBy(desc(counts.approvedAt))
        : [];

      const snapshotCountIds = snapshotQuery.map(c => c.id);
      const allSnapshotLines = snapshotCountIds.length > 0
        ? await db
            .select()
            .from(countLines)
            .where(inArray(countLines.countId, snapshotCountIds))
        : [];

      // Group by shop/item and keep only the latest count line for each combination
      const latestLinesByShopItem = new Map<string, typeof allSnapshotLines[0]>();
      
      for (const line of allSnapshotLines) {
        const count = snapshotQuery.find(c => c.id === line.countId);
        if (!count) continue;
        
        const key = `${count.shopId}-${line.itemId}`;
        const existing = latestLinesByShopItem.get(key);
        
        if (!existing) {
          latestLinesByShopItem.set(key, line);
        } else {
          const existingCount = snapshotQuery.find(c => c.id === existing.countId);
          // Keep the one with the later approval date
          if (existingCount && count.approvedAt && existingCount.approvedAt && 
              new Date(count.approvedAt) > new Date(existingCount.approvedAt)) {
            latestLinesByShopItem.set(key, line);
          }
        }
      }

      const snapshotLines = Array.from(latestLinesByShopItem.values());

      const inventoryData = snapshotLines.map(line => {
        const count = snapshotQuery.find(c => c.id === line.countId);
        const item = itemsMap.get(line.itemId);
        const shop = count ? shopsMap.get(count.shopId) : null;
        const unitsPerBox = item?.unitsPerBox || 1;
        const totalQty = line.boxes + (line.singles / unitsPerBox);

        return {
          'Shop': shop?.name || '',
          'Item SKU': item?.sku || '',
          'Item Name': item?.defaultName || '',
          'Category': item?.category || '',
          'Boxes': line.boxes,
          'Singles': line.singles,
          'Total Qty': totalQty,
          'Count Date': count?.approvedAt ? new Date(count.approvedAt).toISOString().split('T')[0] : '',
          'Period Start': count?.periodStart ? new Date(count.periodStart).toISOString().split('T')[0] : '',
          'Period End': count?.periodEnd ? new Date(count.periodEnd).toISOString().split('T')[0] : ''
        };
      });

      // Sheet 2: Variances - From approved counts with variance data
      const varianceLines = snapshotLines.filter(line => 
        line.varianceSeverity && line.varianceQty !== null
      );

      const variancesData = varianceLines.map(line => {
        const count = snapshotQuery.find(c => c.id === line.countId);
        const item = itemsMap.get(line.itemId);
        const shop = count ? shopsMap.get(count.shopId) : null;
        const unitsPerBox = item?.unitsPerBox || 1;
        const countedQty = line.boxes + (line.singles / unitsPerBox);

        return {
          'Shop': shop?.name || '',
          'Item SKU': item?.sku || '',
          'Item Name': item?.defaultName || '',
          'Counted Qty': countedQty,
          'Expected Qty': line.expectedQty ? parseFloat(line.expectedQty) : 0,
          'Variance Qty': line.varianceQty ? parseFloat(line.varianceQty) : 0,
          'Variance Cost': line.varianceCost ? parseFloat(line.varianceCost) : 0,
          'Severity': line.varianceSeverity || '',
          'Note': line.note || '',
          'Count Date': count?.approvedAt ? new Date(count.approvedAt).toISOString().split('T')[0] : ''
        };
      });

      // Sheet 3: Wastage - Movement records of type WASTAGE
      const wastageMovements = shopIdsToQuery.length > 0
        ? await db
            .select()
            .from(movements)
            .where(
              and(
                inArray(movements.shopId, shopIdsToQuery),
                eq(movements.movementType, 'WASTAGE'),
                gte(movements.movementDate, start),
                lte(movements.movementDate, end)
              )
            )
            .orderBy(desc(movements.movementDate))
        : [];

      const wastageData = wastageMovements.map(movement => {
        const item = itemsMap.get(movement.itemId);
        const shop = shopsMap.get(movement.shopId);

        return {
          'Date': new Date(movement.movementDate).toISOString().split('T')[0],
          'Shop': shop?.name || '',
          'Item SKU': item?.sku || '',
          'Item Name': item?.defaultName || '',
          'Quantity': movement.quantity,
          'Cost': movement.cost || 0,
          'Total Cost': movement.quantity * (movement.cost || 0),
          'Reference': movement.reference || '',
          'Notes': movement.notes || ''
        };
      });

      // Sheet 4: Audit Trail - Event logs for counts and movements
      const auditLogs = await db.query.eventLogs.findMany({
        where: (eventLogs, { and, gte, lte, inArray }) => and(
          gte(eventLogs.timestamp, start),
          lte(eventLogs.timestamp, end),
          inArray(eventLogs.action, ['CREATE_COUNT', 'UPDATE_COUNT', 'SUBMIT_COUNT', 'APPROVE_COUNT', 'REJECT_COUNT', 'CREATE_MOVEMENT', 'LOCK_PERIOD'])
        ),
        orderBy: (eventLogs, { desc }) => [desc(eventLogs.timestamp)],
        limit: 1000
      });

      const auditData = auditLogs.map(log => {
        return {
          'Timestamp': new Date(log.timestamp).toISOString(),
          'Action': log.action,
          'User ID': log.userId,
          'Details': log.payload || ''
        };
      });

      // Create workbook
      const workbook = XLSX.utils.book_new();

      // Add sheets
      const inventorySheet = XLSX.utils.json_to_sheet(inventoryData);
      const variancesSheet = XLSX.utils.json_to_sheet(variancesData);
      const wastageSheet = XLSX.utils.json_to_sheet(wastageData);
      const auditSheet = XLSX.utils.json_to_sheet(auditData);

      XLSX.utils.book_append_sheet(workbook, inventorySheet, 'InventorySnapshot');
      XLSX.utils.book_append_sheet(workbook, variancesSheet, 'Variances');
      XLSX.utils.book_append_sheet(workbook, wastageSheet, 'Wastage');
      XLSX.utils.book_append_sheet(workbook, auditSheet, 'AuditTrail');

      // Generate Excel buffer
      const excelBuffer = XLSX.write(workbook, { type: 'buffer', bookType: 'xlsx' });

      // Set headers for file download
      const filename = `consolidated-report-${new Date().toISOString().split('T')[0]}.xlsx`;
      res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
      res.send(excelBuffer);

      // Log the export action
      await storage.logEvent({
        userId: user.id,
        action: 'EXPORT_CONSOLIDATED',
        payload: JSON.stringify({ 
          startDate: start.toISOString(),
          endDate: end.toISOString(),
          shops: shopIdsToQuery,
          filename
        })
      });
    } catch (error) {
      console.error('Consolidated export error:', error);
      res.status(500).json({ message: "Failed to generate consolidated export" });
    }
  });

}

async function initializeDefaultData() {
  try {
    // Initialize shops (1-10)
    const existingShops = await storage.getAllShops();
    if (existingShops.length === 0) {
      for (let i = 1; i <= 10; i++) {
        await storage.createShop({ id: i, name: `Shop ${i.toString().padStart(2, '0')}` });
      }
    }

    // Initialize items (1-40)
    const existingItems = await storage.getAllItems();
    if (existingItems.length === 0) {
      const categories = ['FOOD', 'DRINK', 'ICECREAM', 'STROMMA'] as const;
      for (let i = 1; i <= 40; i++) {
        const category = categories[(i - 1) % 4];
        await storage.updateItem(i, {
          id: i,
          defaultName: `Item ${i.toString().padStart(2, '0')}`,
          category,
          unitsPerBox: category === 'FOOD' ? 12 : category === 'DRINK' ? 24 : 6
        });
      }
    }
  } catch (error) {
    console.error('Failed to initialize default data:', error);
  }
}
