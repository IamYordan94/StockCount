import { db } from "./db";
import { shopItems, items } from "../shared/schema";
import { eq, and } from "drizzle-orm";
import { fileURLToPath } from 'url';

// Rijksmuseum shop data from Excel with fallback matching
type RijksItem = {
  defaultName: string;
  customName?: string;
  packagingUnit: string;
  displayOrder: number;
};

const rijksmuseumItems: RijksItem[] = [
  // IJSJES category (ICECREAM)
  { defaultName: "OLA Raket", packagingUnit: "per 54 x 55 ml", displayOrder: 1 },
  { defaultName: "OLA Donut", packagingUnit: "per 54 x 55 ml", displayOrder: 2 },
  { defaultName: "OLA Dracula", customName: "OLA Pirulo", packagingUnit: "per 24 x 120ml", displayOrder: 3 }, // Using OLA Dracula as substitute
  { defaultName: "OLA Super Twister", packagingUnit: "per 24 x 120ml", displayOrder: 4 },
  { defaultName: "OLA Magnum Classic", packagingUnit: "per 20 x 120 ml", displayOrder: 5 },
  { defaultName: "OLA Magnum Almond", packagingUnit: "per 20 x 120 ml", displayOrder: 6 },
  { defaultName: "OLA Magnum White", packagingUnit: "per 20 x 120 ml", displayOrder: 7 },
  { defaultName: "OLA Cornetto Classico", packagingUnit: "per 20 x 89ml", displayOrder: 8 },
  
  // DRANK category (DRINK)
  { defaultName: "Heineken blik 0,0 % 33CL", packagingUnit: "per 24 blikjes", displayOrder: 9 },
  { defaultName: "Desperados 33CL", packagingUnit: "per 24 blikjes", displayOrder: 10 },
  { defaultName: "La Croisade chardonnay grenache 25 CL", packagingUnit: "per fles", displayOrder: 11 },
  { defaultName: "La Croisade merlot rouge 25CL", packagingUnit: "per fles", displayOrder: 12 },
  { defaultName: "La Croisade rosé 25CL", packagingUnit: "per fles", displayOrder: 13 },
  { defaultName: "Lisetto Prosecco Klein flesje 20CL", customName: "Lizatro Prosecco Klein flesje 20CL", packagingUnit: "per 10 flesjes", displayOrder: 14 },
  { defaultName: "Lipton Ice Tea Sparkling petfles 50 cl", customName: "Sourcy Sparkling Water Lemon/Limoen/gember 60CL", packagingUnit: "per 6 flesjes ex emb (0,15 per fles", displayOrder: 15 }, // Using Lipton Sparkling as substitute
  { defaultName: "Sourcy Mineraalwater blauw koolzuurvrij pet 50CL", customName: "Sourcy Rood pul 50CL", packagingUnit: "per 6 flesjes ex emb (0,15 per fles", displayOrder: 16 },
  { defaultName: "Sourcy Vitamin Water Braam Acai 0% 50CL", customName: "Sourcy Vitamin Water Biraam Acai 0% 50CL", packagingUnit: "per 6 flesjes ex emb (0,15 per fles", displayOrder: 17 },
  { defaultName: "Sourcy Vitamin Water DruifCitroen 0% 50CL", customName: "Sourcy Vitamin Water DrulCitroen 0% 50CL", packagingUnit: "per 6 flesjes ex emb (0,15 per fles", displayOrder: 18 },
  { defaultName: "Sourcy Vitamin Water Mango Guave 0% 50CL", packagingUnit: "per 6 flesjes ex emb (0,15 per fles", displayOrder: 19 },
  { defaultName: "Rivella 50CL", packagingUnit: "per 6 flesjes ex emb (0,15 per fles", displayOrder: 20 },
  { defaultName: "Ranja fruitmix aardbei/framboos 33CL", customName: "Ramlfruitima aardbel/framboos 33CL", packagingUnit: "per 6 flesjes ex emb (0,15 per fles", displayOrder: 21 },
  { defaultName: "Lipton Ice Tea Sparkling petfles 50 cl", customName: "Lipton Ice Tea original zero 0,5 L", packagingUnit: "per 12 flesjes", displayOrder: 22 }, // Using Lipton Sparkling
  { defaultName: "Lipton Ice Tea peach/green Zero 50 CL", packagingUnit: "per 12 flesjes", displayOrder: 23 },
  { defaultName: "Pepsi petfles regular 50CL", packagingUnit: "per 12 flesjes", displayOrder: 24 },
  { defaultName: "Pepsi petfles max 50CL", packagingUnit: "per 12 flesjes", displayOrder: 25 },
  { defaultName: "Seven Up suikervrij 50 CL", packagingUnit: "per 12 flesjes", displayOrder: 26 },
  { defaultName: "Sisi suikervrij 50CL", packagingUnit: "per 12 flesjes", displayOrder: 27 },
  { defaultName: "Sourcy Mineraalwater blauw koolzuurvrij pet 50CL", customName: "Rook-aar original regular/suikervrij (blik) 25CL", packagingUnit: "per 24 blikjes", displayOrder: 28 }, // Using Sourcy as substitute
  
  // SNACKS category (FOOD)
  { defaultName: "Lay's zakje chips naturel/paprika/bolognese", packagingUnit: "doos per 20 zakjes x 40 gr", displayOrder: 29 },
  { defaultName: "Pringles Original/Sourcream/Hot", customName: "Pringles Original/Sourcry/paprika", packagingUnit: "tray 12 blikjes x 40 gr", displayOrder: 30 },
  { defaultName: "Haribo Starmix 75 gram", packagingUnit: "doos 28 zakjes x 75 gr", displayOrder: 31 },
  { defaultName: "Daelmans stroopwafels jumbo single", packagingUnit: "doos 36 stuks x 39 gr", displayOrder: 32 },
  { defaultName: "Milky way single reep", packagingUnit: "doos 28 stuks x 43 gr", displayOrder: 33 },
  { defaultName: "M&m's pinda single", customName: "Men's pridis single", packagingUnit: "doos 24 zakjes x 45 gr", displayOrder: 34 }, // Using M&M's as substitute
  { defaultName: "Mars single reep", customName: "Mars single", packagingUnit: "doos 24 stuks x 51 gr", displayOrder: 35 },
  { defaultName: "Snickers single reep", packagingUnit: "doos 32 stuks x 50 gr", displayOrder: 36 },
  { defaultName: "Twix single reep", packagingUnit: "doos 32 stuks x 50 gr", displayOrder: 37 },
  { defaultName: "KitKat chocobar", customName: "Kit-Kat chocolaar", packagingUnit: "doos 36 stuks x 416 gr", displayOrder: 38 },
  
  // STROMMA BRANDED category (STROMMA)
  { defaultName: "Stroopwafel zakje", packagingUnit: "verpakkingsleenheid", displayOrder: 39 },
  { defaultName: "Oud hollandse candy's", packagingUnit: "doos 60 stuks x 50g", displayOrder: 40 },
  { defaultName: "Daelmans Mini stroopwafel blokzak", customName: "Stroopwafel cake", packagingUnit: "doos 60 stuks x 100g", displayOrder: 41 }, // Using Daelmans as substitute
  { defaultName: "Stroopwafel koker yellow box", packagingUnit: "Aantal verpakking", displayOrder: 42 },
  { defaultName: "Pretzel", packagingUnit: "doos 60 stuks x 100g", displayOrder: 43 },
  { defaultName: "Pickwick Theezakjes Earl Grey Met Envelop Pak 100 zakjes x 2 gram", customName: "Hazelnia", packagingUnit: "doos 60 stuks x 100g", displayOrder: 44 }, // Using Pickwick as temporary substitute
  { defaultName: "Cheese Cubes Mature/ 4-6 months", customName: "Cheese", packagingUnit: "doos 60 stuks x 100g", displayOrder: 45 },
  { defaultName: "Cubes Mature/ 4-6 months", customName: "Cubes Mature/ 4.5 months", packagingUnit: "per 12 x 135g", displayOrder: 46 },
];

export async function updateRijksmuseumShop() {
  console.log("Starting Rijksmuseum shop update...");
  
  try {
    // Delete existing shop items for Rijksmuseum (shop ID 2)
    console.log("Deleting existing shop items for Rijksmuseum...");
    await db.delete(shopItems).where(eq(shopItems.shopId, 2));
    
    // Find all items and create a map
    const allItems = await db.select().from(items);
    const itemMap = new Map(allItems.map(item => [item.defaultName.toLowerCase().trim(), item]));
    
    // Create new shop items with custom data
    const newShopItems = [];
    const notFoundItems = [];
    
    for (const rijksItem of rijksmuseumItems) {
      const searchName = rijksItem.defaultName.toLowerCase().trim();
      const matchedItem = itemMap.get(searchName);
      
      if (matchedItem) {
        newShopItems.push({
          shopId: 2,
          itemId: matchedItem.id,
          active: true,
          customName: rijksItem.customName || null, // Use custom name if provided
          packagingUnit: rijksItem.packagingUnit,
          displayOrder: rijksItem.displayOrder,
        });
      } else {
        notFoundItems.push(rijksItem.defaultName);
      }
    }
    
    // Insert new shop items
    console.log(`Inserting ${newShopItems.length} shop items...`);
    if (newShopItems.length > 0) {
      await db.insert(shopItems).values(newShopItems);
    }
    
    console.log("✅ Rijksmuseum shop update complete!");
    console.log(`✓ Added ${newShopItems.length} items`);
    
    if (notFoundItems.length > 0) {
      console.log(`⚠️  Items not found in database (${notFoundItems.length}):`);
      notFoundItems.forEach(name => console.log(`   - ${name}`));
    }
    
  } catch (error) {
    console.error("❌ Error updating Rijksmuseum shop:", error);
    throw error;
  }
}

// Run if executed directly
if (import.meta.url === `file://${process.argv[1]}`) {
  updateRijksmuseumShop()
    .then(() => process.exit(0))
    .catch((err) => {
      console.error(err);
      process.exit(1);
    });
}
