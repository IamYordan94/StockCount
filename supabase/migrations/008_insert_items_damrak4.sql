-- Insert items and shop-item assignments for Damrak 4 shop
-- This migration adds all items from Damrak 4 shop
-- Uses subqueries to resolve category and shop IDs by name
-- Uses ON CONFLICT to handle duplicate items that may exist from other shops

-- Helper function to get category ID and insert new items
DO $$
DECLARE
  cat_food_id UUID;
  cat_drinks_id UUID;
  cat_cheese_id UUID;
  cat_other_id UUID;
BEGIN
  SELECT id INTO cat_food_id FROM categories WHERE name = 'Food';
  SELECT id INTO cat_drinks_id FROM categories WHERE name = 'Drinks';
  SELECT id INTO cat_cheese_id FROM categories WHERE name = 'Cheese';
  SELECT id INTO cat_other_id FROM categories WHERE name = 'Other';

  -- Insert new items that don't exist yet
  -- DRANK SHOP (Drinks)
  INSERT INTO items (name, category_id, pack_size) VALUES
    ('Gluhwein', cat_drinks_id, 'per 1 x5L'),
    ('Chocomel', cat_drinks_id, 'per 12 cartons x 1L')
  ON CONFLICT (name, category_id) DO NOTHING;
END $$;

-- Create shop-item assignments for Damrak 4
-- DRANK SHOP items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Damrak 4'),
  id
FROM items
WHERE name IN (
  'Heineken blik 33CL',
  'La Croisade chardonnay grenache 25CL',
  'La Croisade merlot rouge 25CL',
  'Lisetto Prosecco Klein flesje 20CL',
  'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL',
  'Sourcy Rood pet 50CL',
  'Lipton Ice Tea Sparkling petfles 50CL',
  'Lipton Ice Tea Peach/green Zero 50CL',
  'Pepsi Regular 50CL',
  'Pepsi regular 50CL',
  'Pepsi petfles max 50CL',
  'Seven Up suikervrij 50CL',
  'Sisi suikervrij 50CL',
  'Gluhwein',
  'Chocomel'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- ETEN (Food) items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Damrak 4'),
  id
FROM items
WHERE name IN (
  'Lay''s zakje chips naturel/paprika/bolognese',
  'Pringles Original/Sourcream/Hot',
  'M&M''s pinda single',
  'Mars single reep',
  'Snickers single reep',
  'Twix single reep',
  'KitKat chocobar'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- STROMMA BRANDED (Other category) items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Damrak 4'),
  id
FROM items
WHERE name IN (
  'Oud hollandse candy''s',
  'Stroopwafel zakje',
  'Stroopwafel koker yellow box',
  'Pretzel',
  'Huismix'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- KAAS (Cheese) items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Damrak 4'),
  id
FROM items
WHERE name IN (
  'Cubes Mature / 4–6 months'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

