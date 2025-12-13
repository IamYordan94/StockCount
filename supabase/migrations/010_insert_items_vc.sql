-- Insert items and shop-item assignments for VC shop
-- This migration adds all items from VC shop
-- Uses subqueries to resolve category and shop IDs by name
-- Uses ON CONFLICT to handle duplicate items that may exist from other shops

-- Create shop-item assignments for VC
-- DRANK SHOP items (based on the item shown in the image)
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'VC'),
  id
FROM items
WHERE name IN (
  'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- Note: If VC shop has additional items, add them to the appropriate sections below
-- Uncomment and modify the sections below as needed when you have the full item list

/*
-- Additional DRANK SHOP items (uncomment and add items as needed)
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'VC'),
  id
FROM items
WHERE name IN (
  'Heineken blik 33CL',
  'La Croisade chardonnay grenache 25CL',
  -- Add more drink items here
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- ETEN (Food) items (uncomment and add items as needed)
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'VC'),
  id
FROM items
WHERE name IN (
  'Lay''s zakje chips naturel/paprika/bolognese',
  -- Add more food items here
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- IJSJES (Ice Cream) items (uncomment and add items as needed)
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'VC'),
  id
FROM items
WHERE name IN (
  'OLA Raket',
  -- Add more ice cream items here
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- STROMMA BRANDED items (uncomment and add items as needed)
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'VC'),
  id
FROM items
WHERE name IN (
  'Oud hollandse candy''s',
  -- Add more branded items here
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- KAAS (Cheese) items (uncomment and add items as needed)
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'VC'),
  id
FROM items
WHERE name IN (
  'Cubes Mature / 4–6 months'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;
*/

