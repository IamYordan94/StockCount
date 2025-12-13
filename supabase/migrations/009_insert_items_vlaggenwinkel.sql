-- Insert items and shop-item assignments for Vlaggenwinkel shop
-- This migration adds all items from Vlaggenwinkel shop
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
    ('Brand IPA 33CL', cat_drinks_id, 'per 12 blikjes')
  ON CONFLICT (name, category_id) DO NOTHING;
END $$;

-- Create shop-item assignments for Vlaggenwinkel
-- DRANK SHOP items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Vlaggenwinkel'),
  id
FROM items
WHERE name IN (
  'Heineken blik 33CL',
  'Heineken blik 0,0% 33CL',
  'Brand IPA 33CL',
  'La Croisade chardonnay grenache 25CL',
  'La Croisade merlot rouge 25CL',
  'La Croisade rosé 25CL',
  'Lisetto Prosecco Klein flesje 20CL',
  'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL',
  'Sourcy Rood pet 50CL',
  'Sourcy Vitamin Water Braam Acai 0% 50CL',
  'Sourcy Vitamin Water Druif/Citroen 0% 50CL',
  'Sourcy Vitamin Water Mango Guave 0% 50CL',
  'Rivella 50CL',
  'Ranja fruitmix aardbei/framboos 33CL',
  'Lipton Ice Tea Sparkling petfles 50CL',
  'Lipton Ice Tea Peach/green Zero 50CL',
  'Pepsi Regular 50CL',
  'Pepsi regular 50CL',
  'Pepsi petfles max 50CL',
  'Seven Up suikervrij 50CL',
  'Sisi suikervrij 50CL',
  'Rockstar original/regular/suikervrij (blik) 25CL'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- ETEN (Food) items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Vlaggenwinkel'),
  id
FROM items
WHERE name IN (
  'Lay''s zakje chips naturel/paprika/bolognese',
  'Pringles Original/Sourcream/Hot',
  'Haribo Starmix 75 gram',
  'Daelmans stroopwafels jumbo single',
  'Milky way single reep',
  'M&M''s pinda single',
  'Mars single reep',
  'Snickers single reep',
  'Twix single reep',
  'KitKat chocobar',
  'Duyvis Pinda''s gezouten nootjes'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- IJSJES (Ice Cream) - Other category items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Vlaggenwinkel'),
  id
FROM items
WHERE name IN (
  'OLA Raket',
  'OLA Donut',
  'OLA Dracula',
  'OLA Super Twister',
  'OLA Magnum Classic',
  'OLA Magnum Almond',
  'OLA Magnum White',
  'OLA Cornetto Classico'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- STROMMA BRANDED (Other category) items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Vlaggenwinkel'),
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
  (SELECT id FROM shops WHERE name = 'Vlaggenwinkel'),
  id
FROM items
WHERE name IN (
  'Cubes Mature / 4–6 months'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

