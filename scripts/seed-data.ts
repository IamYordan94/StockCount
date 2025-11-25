import { db } from "../server/db";
import { users, shops, items, userShops, sessions } from "../shared/schema";
import { scrypt, randomBytes } from "crypto";
import { promisify } from "util";

const scryptAsync = promisify(scrypt);

async function hashPassword(password: string) {
  const salt = randomBytes(16).toString("hex");
  const buf = (await scryptAsync(password, salt, 64)) as Buffer;
  return `${buf.toString("hex")}.${salt}`;
}

async function main() {
  console.log("🌱 Seeding database...");

  try {
    // Create admin user
    const adminPassword = await hashPassword("admin123");
    const [adminUser] = await db.insert(users).values({
      name: "Admin User",
      username: "admin",
      password: adminPassword,
      role: "OWNER",
      approved: true,
      mustResetPassword: false,
    }).returning().onConflictDoNothing();

    // Create employee user
    const employeePassword = await hashPassword("employee123");
    const [employeeUser] = await db.insert(users).values({
      name: "John Employee",
      username: "employee",
      password: employeePassword,
      role: "EMPLOYEE",
      approved: true,
      mustResetPassword: false,
    }).returning().onConflictDoNothing();

    console.log("✅ Created test users:");
    console.log("   Admin: username=admin, password=admin123");
    console.log("   Employee: username=employee, password=employee123");

    // Create shops (1-10) if they don't exist
    const shopData = [];
    for (let i = 1; i <= 10; i++) {
      shopData.push({
        id: i,
        name: `Shop ${i.toString().padStart(2, '0')}`,
        active: true,
      });
    }
    
    await db.insert(shops).values(shopData).onConflictDoNothing();
    console.log("✅ Created 10 shops");

    // Create items (1-40) if they don't exist
    const itemData = [];
    const categories = ['FOOD', 'DRINK', 'ICECREAM', 'STROMMA'] as const;
    for (let i = 1; i <= 40; i++) {
      const category = categories[(i - 1) % 4];
      itemData.push({
        id: i,
        defaultName: `${category} Item ${i.toString().padStart(2, '0')}`,
        category,
        unitsPerBox: category === 'FOOD' ? 12 : category === 'DRINK' ? 24 : 6,
      });
    }
    
    await db.insert(items).values(itemData).onConflictDoNothing();
    console.log("✅ Created 40 items across 4 categories");

    // Assign employee to shops 1-3
    if (employeeUser) {
      const assignments = [];
      for (let shopId = 1; shopId <= 3; shopId++) {
        assignments.push({
          userId: employeeUser.id,
          shopId,
        });
      }
      
      await db.insert(userShops).values(assignments).onConflictDoNothing();
      console.log("✅ Assigned employee to shops 1-3");
    }

    // Create a default session
    const [session] = await db.insert(sessions).values({
      name: "Demo Session - " + new Date().toISOString().split('T')[0],
      status: "OPEN",
    }).returning().onConflictDoNothing();

    if (session) {
      console.log(`✅ Created demo session: ${session.name}`);
    }

    console.log("\n🎉 Database seeded successfully!");
    console.log("\n📝 Login Credentials:");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    console.log("🔑 ADMIN ACCESS:");
    console.log("   Username: admin");
    console.log("   Password: admin123");
    console.log("   Access: Full admin dashboard, user management, exports");
    console.log("");
    console.log("👤 EMPLOYEE ACCESS:");
    console.log("   Username: employee");
    console.log("   Password: employee123");
    console.log("   Access: Shops 1-3 for inventory counting");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

  } catch (error) {
    console.error("❌ Error seeding database:", error);
    process.exit(1);
  }
}

main().then(() => process.exit(0));