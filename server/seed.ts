import { db } from './db';
import { users, shops, items, shopItems, userShops } from '@shared/schema';
import { sql } from 'drizzle-orm';
import { readFileSync } from 'fs';
import { join } from 'path';
import { hashPassword } from './auth';

// Load full seed data from JSON file
function loadSeedData() {
  try {
    const seedDataPath = join(__dirname, 'seed-data.json');
    const seedDataRaw = readFileSync(seedDataPath, 'utf8');
    return JSON.parse(seedDataRaw);
  } catch (error) {
    console.error('❌ Failed to load seed data:', error);
    throw error;
  }
}

// Prepare user data with proper password handling
async function prepareUserData(seedData: any) {
  const usersToInsert = [];
  
  for (const user of seedData.users) {
    let password = user.password;
    
    // Handle empty or plaintext passwords
    if (!password || !password.includes('.')) {
      // For empty passwords, set a default password
      if (!password) {
        password = await hashPassword('changeme123');
      } else {
        // Hash plaintext passwords
        password = await hashPassword(password);
      }
    }
    
    usersToInsert.push({
      id: user.id,
      username: user.username,
      password,
      name: user.name,
      role: user.role,
      approved: user.approved,
      mustResetPassword: !user.password || !user.password.includes('.')
    });
  }
  
  return usersToInsert;
}

export async function seedDatabase() {
  try {
    // Check if database already has data (check all core tables for robustness)
    const [shopResult, userResult, itemResult] = await Promise.all([
      db.select({ count: sql<number>`count(*)` }).from(shops),
      db.select({ count: sql<number>`count(*)` }).from(users),
      db.select({ count: sql<number>`count(*)` }).from(items)
    ]);
    
    const shopCount = Number(shopResult[0]?.count || 0);
    const userCount = Number(userResult[0]?.count || 0);
    const itemCount = Number(itemResult[0]?.count || 0);

    // Only seed if ALL core tables are empty
    if (shopCount > 0 || userCount > 0 || itemCount > 0) {
      if (process.env.NODE_ENV === 'development') {
        console.log('✅ Database already seeded, skipping...');
      }
      return;
    }

    if (process.env.NODE_ENV === 'development') {
      console.log('📦 Seeding database with initial data...');
    }

    // Load seed data
    const seedData = loadSeedData();

    const shopsToInsert = (seedData.shops ?? []).map((shop: any) => ({
      id: shop.id,
      name: shop.name,
      active: shop.active ?? true,
    }));

    const itemsToInsert = (seedData.items ?? []).map((item: any) => ({
      id: item.id,
      defaultName: item.default_name,
      category: item.category,
      unitsPerBox: item.units_per_box ?? 1,
      uom: item.uom ?? "unit",
      packSize: item.pack_size ? String(item.pack_size) : "1",
      sku: item.sku ?? null,
      isActive: item.is_active ?? true,
    }));

    const shopItemsToInsert = (seedData.shopItems ?? []).map((shopItem: any) => ({
      shopId: shopItem.shop_id,
      itemId: shopItem.item_id,
      active: shopItem.active ?? true,
      customName: shopItem.custom_name ?? null,
      packagingUnit: shopItem.packaging_unit ?? null,
      displayOrder: shopItem.display_order ?? null,
    }));

    const userShopsToInsert = (seedData.userShops ?? []).map((link: any) => ({
      userId: link.user_id,
      shopId: link.shop_id,
    }));

    // Prepare users with proper password handling
    const usersToInsert = await prepareUserData(seedData);

    // Execute all inserts within a single transaction
    await db.transaction(async (tx) => {
      // Seed users first (other tables depend on this)
      await tx.insert(users).values(usersToInsert);

      // Seed shops
      await tx.insert(shops).values(shopsToInsert);

      // Seed items (all 383 items)
      await tx.insert(items).values(itemsToInsert);

      // Seed shop_items (382 configurations)
      await tx.insert(shopItems).values(shopItemsToInsert);

      // Seed user_shops (permissions)
      await tx.insert(userShops).values(userShopsToInsert);
    });

    if (process.env.NODE_ENV === 'development') {
      console.log('✅ Database seeded successfully!');
      console.log('   Admin account ready - check replit.md for credentials');
    }
  } catch (error) {
    console.error('❌ Error seeding database:', error);
    console.error('   Server will continue but database may be empty.');
    console.error('   If this persists, please check logs and contact support.');
  }
}
