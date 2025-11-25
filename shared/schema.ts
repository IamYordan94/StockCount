import { sql, relations } from "drizzle-orm";
import { pgTable, text, varchar, integer, timestamp, boolean, pgEnum, decimal } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";

// Enums
export const userRoleEnum = pgEnum('user_role', ['OWNER', 'SUPERVISOR', 'EMPLOYEE']);
export const categoryEnum = pgEnum('category', ['FOOD', 'DRINK', 'ICECREAM', 'STROMMA']);
export const sessionStatusEnum = pgEnum('session_status', ['OPEN', 'CLOSED']);
export const countStatusEnum = pgEnum('count_status', ['DRAFT', 'SUBMITTED', 'APPROVED', 'REJECTED']);
export const movementTypeEnum = pgEnum('movement_type', ['PURCHASE', 'SALE', 'TRANSFER_IN', 'TRANSFER_OUT', 'WASTAGE', 'OPENING']);
export const varianceSeverityEnum = pgEnum('variance_severity', ['INFO', 'WARN', 'CRITICAL']);

// Users table
export const users = pgTable("users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  username: text("username").notNull().unique(),
  password: text("password").notNull(),
  mustResetPassword: boolean("must_reset_password").notNull().default(true),
  approved: boolean("approved").notNull().default(false),
  role: userRoleEnum("role").notNull().default('EMPLOYEE'),
  createdAt: timestamp("created_at").notNull().default(sql`now()`),
  lastLoginAt: timestamp("last_login_at"),
  loginAttempts: integer("login_attempts").notNull().default(0),
  lockedUntil: timestamp("locked_until"),
});

// Shops table (1-10)
export const shops = pgTable("shops", {
  id: integer("id").primaryKey(), // 1 through 10
  name: text("name").notNull(),
  active: boolean("active").notNull().default(true),
});

// Items table (1-40)
export const items = pgTable("items", {
  id: integer("id").primaryKey(), // 1 through 40
  sku: text("sku"),
  defaultName: text("default_name").notNull(),
  category: categoryEnum("category").notNull(),
  uom: text("uom").notNull().default('unit'), // unit of measure (e.g., 'unit', 'kg', 'liter', 'bottle')
  packSize: decimal("pack_size", { precision: 10, scale: 2 }).notNull().default('1'), // size per unit (e.g., 0.7 for 700ml bottle)
  unitsPerBox: integer("units_per_box").notNull().default(1),
  isActive: boolean("is_active").notNull().default(true),
});

// User shop permissions
export const userShops = pgTable("user_shops", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: 'cascade' }),
  shopId: integer("shop_id").notNull().references(() => shops.id, { onDelete: 'cascade' }),
});

// Shop item visibility overrides
export const shopItems = pgTable("shop_items", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  shopId: integer("shop_id").notNull().references(() => shops.id, { onDelete: 'cascade' }),
  itemId: integer("item_id").notNull().references(() => items.id, { onDelete: 'cascade' }),
  active: boolean("active").notNull().default(true),
  customName: text("custom_name"),
  packagingUnit: text("packaging_unit"),
  displayOrder: integer("display_order"),
});

// Inventory sessions
export const sessions = pgTable("sessions", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  status: sessionStatusEnum("status").notNull().default('OPEN'),
  createdAt: timestamp("created_at").notNull().default(sql`now()`),
  closedAt: timestamp("closed_at"),
  autoCloseAt: timestamp("auto_close_at"), // Auto-close session after 3 days
});

// Count records
export const counts = pgTable("counts", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  sessionId: varchar("session_id").notNull().references(() => sessions.id, { onDelete: 'cascade' }),
  shopId: integer("shop_id").notNull().references(() => shops.id, { onDelete: 'cascade' }),
  userId: varchar("user_id").notNull().references(() => users.id, { onDelete: 'cascade' }), // creator
  status: countStatusEnum("status").notNull().default('DRAFT'),
  periodStart: timestamp("period_start"),
  periodEnd: timestamp("period_end"),
  submittedAt: timestamp("submitted_at"),
  submittedBy: varchar("submitted_by").references(() => users.id, { onDelete: 'set null' }),
  approvedAt: timestamp("approved_at"),
  approvedBy: varchar("approved_by").references(() => users.id, { onDelete: 'set null' }),
  rejectionReason: text("rejection_reason"),
  reopenReason: text("reopen_reason"),
  lockVersion: integer("lock_version").notNull().default(0), // for optimistic locking
  createdAt: timestamp("created_at").notNull().default(sql`now()`),
  updatedAt: timestamp("updated_at").notNull().default(sql`now()`),
});

// Count line items
export const countLines = pgTable("count_lines", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  countId: varchar("count_id").notNull().references(() => counts.id, { onDelete: 'cascade' }),
  itemId: integer("item_id").notNull().references(() => items.id, { onDelete: 'cascade' }),
  boxes: integer("boxes").notNull().default(0),
  singles: integer("singles").notNull().default(0),
  note: text("note"), // line-level comment for variances or recounts
  recountRequested: boolean("recount_requested").notNull().default(false),
  // Variance computation fields
  expectedQty: decimal("expected_qty", { precision: 10, scale: 2 }),
  varianceQty: decimal("variance_qty", { precision: 10, scale: 2 }),
  varianceCost: decimal("variance_cost", { precision: 10, scale: 2 }),
  varianceSeverity: varianceSeverityEnum("variance_severity"),
  computedAt: timestamp("computed_at"),
});

// Event log for audit trail
export const eventLogs = pgTable("event_logs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar("user_id").references(() => users.id, { onDelete: 'set null' }),
  action: text("action").notNull(),
  payload: text("payload"), // JSON string
  beforeJson: text("before_json"), // state before change
  afterJson: text("after_json"), // state after change
  entityType: text("entity_type"), // e.g., 'count', 'item', 'cost'
  entityId: text("entity_id"), // ID of the changed entity
  timestamp: timestamp("timestamp").notNull().default(sql`now()`),
});

// Item costs - time-series pricing
export const costs = pgTable("costs", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  itemId: integer("item_id").notNull().references(() => items.id, { onDelete: 'cascade' }),
  costPerUom: decimal("cost_per_uom", { precision: 10, scale: 2 }).notNull(), // cost per unit of measure
  currency: text("currency").notNull().default('EUR'),
  effectiveFrom: timestamp("effective_from").notNull().default(sql`now()`),
  createdAt: timestamp("created_at").notNull().default(sql`now()`),
});

// Stock movements (purchases, sales, transfers, wastage)
export const movements = pgTable("movements", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  shopId: integer("shop_id").notNull().references(() => shops.id, { onDelete: 'cascade' }),
  itemId: integer("item_id").notNull().references(() => items.id, { onDelete: 'cascade' }),
  type: movementTypeEnum("type").notNull(),
  quantity: decimal("quantity", { precision: 10, scale: 2 }).notNull(), // total quantity in UOM
  sourceRef: text("source_ref"), // external reference (e.g., POS transaction ID, invoice number)
  occurredAt: timestamp("occurred_at").notNull().default(sql`now()`),
  createdAt: timestamp("created_at").notNull().default(sql`now()`),
});

// Variance detection thresholds
export const varianceThresholds = pgTable("variance_thresholds", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  shopId: integer("shop_id").references(() => shops.id, { onDelete: 'cascade' }), // null = global default
  itemId: integer("item_id").references(() => items.id, { onDelete: 'cascade' }), // null = applies to all items
  warnPercentage: decimal("warn_percentage", { precision: 5, scale: 2 }).notNull().default('3'), // 3%
  criticalPercentage: decimal("critical_percentage", { precision: 5, scale: 2 }).notNull().default('10'), // 10%
  warnAbsolute: decimal("warn_absolute", { precision: 10, scale: 2 }).notNull().default('0.5'), // 0.5 UOM
  criticalAbsolute: decimal("critical_absolute", { precision: 10, scale: 2 }).notNull().default('2'), // 2 UOM
  effectiveFrom: timestamp("effective_from").notNull().default(sql`now()`),
});

// Relations
export const usersRelations = relations(users, ({ many }) => ({
  userShops: many(userShops),
  counts: many(counts),
  eventLogs: many(eventLogs),
}));

export const shopsRelations = relations(shops, ({ many }) => ({
  userShops: many(userShops),
  shopItems: many(shopItems),
  counts: many(counts),
  movements: many(movements),
}));

export const itemsRelations = relations(items, ({ many }) => ({
  shopItems: many(shopItems),
  countLines: many(countLines),
  costs: many(costs),
  movements: many(movements),
}));

export const userShopsRelations = relations(userShops, ({ one }) => ({
  user: one(users, { fields: [userShops.userId], references: [users.id] }),
  shop: one(shops, { fields: [userShops.shopId], references: [shops.id] }),
}));

export const shopItemsRelations = relations(shopItems, ({ one }) => ({
  shop: one(shops, { fields: [shopItems.shopId], references: [shops.id] }),
  item: one(items, { fields: [shopItems.itemId], references: [items.id] }),
}));

export const sessionsRelations = relations(sessions, ({ many }) => ({
  counts: many(counts),
}));

export const countsRelations = relations(counts, ({ one, many }) => ({
  session: one(sessions, { fields: [counts.sessionId], references: [sessions.id] }),
  shop: one(shops, { fields: [counts.shopId], references: [shops.id] }),
  user: one(users, { fields: [counts.userId], references: [users.id] }),
  countLines: many(countLines),
}));

export const countLinesRelations = relations(countLines, ({ one }) => ({
  count: one(counts, { fields: [countLines.countId], references: [counts.id] }),
  item: one(items, { fields: [countLines.itemId], references: [items.id] }),
}));

export const eventLogsRelations = relations(eventLogs, ({ one }) => ({
  user: one(users, { fields: [eventLogs.userId], references: [users.id] }),
}));

export const costsRelations = relations(costs, ({ one }) => ({
  item: one(items, { fields: [costs.itemId], references: [items.id] }),
}));

export const movementsRelations = relations(movements, ({ one }) => ({
  shop: one(shops, { fields: [movements.shopId], references: [shops.id] }),
  item: one(items, { fields: [movements.itemId], references: [items.id] }),
}));

export const varianceThresholdsRelations = relations(varianceThresholds, ({ one }) => ({
  shop: one(shops, { fields: [varianceThresholds.shopId], references: [shops.id] }),
  item: one(items, { fields: [varianceThresholds.itemId], references: [items.id] }),
}));

// Insert schemas
export const insertUserSchema = createInsertSchema(users).omit({
  id: true,
  createdAt: true,
  lastLoginAt: true,
  loginAttempts: true,
  lockedUntil: true,
});

export const insertShopSchema = createInsertSchema(shops);

export const insertItemSchema = createInsertSchema(items);

export const insertUserShopSchema = createInsertSchema(userShops).omit({
  id: true,
});

export const insertShopItemSchema = createInsertSchema(shopItems).omit({
  id: true,
});

export const insertSessionSchema = createInsertSchema(sessions).omit({
  id: true,
  createdAt: true,
  closedAt: true,
});

export const insertCountSchema = createInsertSchema(counts).omit({
  id: true,
  createdAt: true,
  updatedAt: true,
});

export const insertCountLineSchema = createInsertSchema(countLines).omit({
  id: true,
});

export const insertEventLogSchema = createInsertSchema(eventLogs).omit({
  id: true,
  timestamp: true,
});

export const insertCostSchema = createInsertSchema(costs).omit({
  id: true,
  createdAt: true,
});

export const insertMovementSchema = createInsertSchema(movements).omit({
  id: true,
  createdAt: true,
});

export const insertVarianceThresholdSchema = createInsertSchema(varianceThresholds).omit({
  id: true,
});

// Types
export type User = typeof users.$inferSelect;
export type InsertUser = z.infer<typeof insertUserSchema>;
export type Shop = typeof shops.$inferSelect;
export type InsertShop = z.infer<typeof insertShopSchema>;
export type Item = typeof items.$inferSelect;
export type InsertItem = z.infer<typeof insertItemSchema>;
export type UserShop = typeof userShops.$inferSelect;
export type InsertUserShop = z.infer<typeof insertUserShopSchema>;
export type ShopItem = typeof shopItems.$inferSelect;
export type InsertShopItem = z.infer<typeof insertShopItemSchema>;
export type Session = typeof sessions.$inferSelect;
export type InsertSession = z.infer<typeof insertSessionSchema>;
export type Count = typeof counts.$inferSelect;
export type InsertCount = z.infer<typeof insertCountSchema>;
export type CountLine = typeof countLines.$inferSelect;
export type InsertCountLine = z.infer<typeof insertCountLineSchema>;
export type EventLog = typeof eventLogs.$inferSelect;
export type InsertEventLog = z.infer<typeof insertEventLogSchema>;
export type Cost = typeof costs.$inferSelect;
export type InsertCost = z.infer<typeof insertCostSchema>;
export type Movement = typeof movements.$inferSelect;
export type InsertMovement = z.infer<typeof insertMovementSchema>;
export type VarianceThreshold = typeof varianceThresholds.$inferSelect;
export type InsertVarianceThreshold = z.infer<typeof insertVarianceThresholdSchema>;
