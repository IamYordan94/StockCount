-- Insert items and shop-item assignments for first 4 shops
-- This migration adds all items from Winkel Rijks, Ponton Rijks, ARK Rijks, and Leidse
-- Uses subqueries to resolve category and shop IDs by name
-- Uses ON CONFLICT to handle duplicate items across shops

-- Helper function to get category ID
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

  -- Insert items (using ON CONFLICT to handle duplicates)
  -- IJSJES (Ice Cream) - Other category
  INSERT INTO items (name, category_id, pack_size) VALUES
    ('OLA Raket', cat_other_id, 'per 54 a 55 ml'),
    ('OLA Donut', cat_other_id, 'per 54 a 55 ml'),
    ('OLA Dracula', cat_other_id, 'per 35 a 55 ml'),
    ('OLA Super Twister', cat_other_id, 'per 24 a 120 ml'),
    ('OLA Magnum Classic', cat_other_id, 'per 20 a 110 ml'),
    ('OLA Magnum Almond', cat_other_id, 'per 20 a 120 ml'),
    ('OLA Magnum White', cat_other_id, 'per 20 a 120 ml'),
    ('OLA Cornetto Classico', cat_other_id, 'per 20 a 85ml')
  ON CONFLICT (name, category_id) DO NOTHING;

  -- DRANK (Drinks)
  INSERT INTO items (name, category_id, pack_size) VALUES
    ('Heineken blik 33CL', cat_drinks_id, 'per 24 blikjes'),
    ('Heineken blik 0,0% 33CL', cat_drinks_id, 'per 24 blikjes'),
    ('Desperados 33CL', cat_drinks_id, 'per 24 blikjes'),
    ('La Croisade chardonnay grenache 25CL', cat_drinks_id, 'per fles'),
    ('La Croisade merlot rouge 25CL', cat_drinks_id, 'per fles'),
    ('La Croisade rosé 25CL', cat_drinks_id, 'per fles'),
    ('Lisetto Prosecco Klein flesje 20CL', cat_drinks_id, 'per 12 flesjes'),
    ('Sourcy Mineraalwater blauw koolzuurvrij pet 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Sourcy Rood pet 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Sourcy Vitamin Water Braam Acai 0% 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Sourcy Vitamin Water Druif/Citroen 0% 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Sourcy Vitamin Water Lemon/Mango Guave 0% 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Sourcy Vitamin Water Mango Guave 0% 50CL', cat_drinks_id, 'per 6 flesjes ex emb €0,15 per fles'),
    ('Rivella 50CL', cat_drinks_id, 'per 8 pieces'),
    ('Ranja fruitmix aardbei/framboos 33CL', cat_drinks_id, 'per 8 pieces'),
    ('Lipton Ice Tea Sparkling petfles 50CL', cat_drinks_id, 'per 12 flesjes'),
    ('Lipton Ice Tea Peach petfles 50CL', cat_drinks_id, 'per 12 flesjes'),
    ('Lipton Ice Tea Peach/green Zero 50CL', cat_drinks_id, 'per 12 flesjes ex emb €0,15 per fles'),
    ('Pepsi Regular 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Pepsi regular 50CL', cat_drinks_id, 'per 6 flesjes ex emb €0,15 per fles'),
    ('Pepsi petfles max 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Seven Up suikervrij 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Sisi suikervrij 50CL', cat_drinks_id, 'per 6 pieces'),
    ('Rockstar original/regular/suikervrij (blik) 25CL', cat_drinks_id, 'per 12 blikjes'),
    ('Segura Viudas Cava Brut Fles 75 cl', cat_drinks_id, 'per doos 6 stuks'),
    ('Marula Rose 75 cl', cat_drinks_id, 'per doos 6 stuks'),
    ('Lisetto Prosecco Spumante Fles 75 cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('Laroche Wine Chardonnay Fles 75 cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('Laroche Rood Merlot Fles 75 cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('Laroche Rosé Fles 75 cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('La Croisade Chardonnay grenache 75cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('La Croisade Merlot rouge 75cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('La Croisade rosé 75cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('Heineken Pilsener Star Bottle krat', cat_drinks_id, 'per krat 24 stuks + 30cl'),
    ('Heineken 0,0% krat', cat_drinks_id, 'per krat 24 stuks'),
    ('Sourcy Rood mineraalwater 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Sourcy Blauw mineraalwater koolzuurvrij fles 20 cl krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Pepsi Regular cola 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Pepsi Max cola 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('7 Up Free 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Sisi Suikerwitte Sinas 20cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Lipton Ice tea green 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Royal Club Cassisappael 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Royal Club Apfelsap 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Sourcy Natuurmin. mineraalwater koolzuurvrij 75 cl', cat_drinks_id, 'krat per 12'),
    ('Sourcy Rood mineraalwater 75 cl', cat_drinks_id, 'krat per 12')
  ON CONFLICT (name, category_id) DO NOTHING;

  -- ETEN (Food)
  INSERT INTO items (name, category_id, pack_size) VALUES
    ('Lay''s zakje chips naturel/paprika/bolognese', cat_food_id, 'doos per 20 zakjes a 40 gr'),
    ('Pringles Original/Sourcream/Hot', cat_food_id, 'tray 12 blikjes a 40 gr'),
    ('Haribo Starmix 75 gram', cat_food_id, 'doos 28 zakjes a 75 gr'),
    ('Daelmans stroopwafels jumbo single', cat_food_id, 'doos 36 stuks a 33 gr'),
    ('Milky way single reep', cat_food_id, 'doos 28 stuks a 43 gr'),
    ('M&M''s pinda single', cat_food_id, 'doos 24 zakjes a 45 gr'),
    ('Mars single reep', cat_food_id, 'doos 32 stuks a 51 gr'),
    ('Snickers single reep', cat_food_id, 'doos 32 stuks a 50 gr'),
    ('Twix single reep', cat_food_id, 'doos 25 stuks a 50 gr'),
    ('KitKat chocobar', cat_food_id, 'doos 36 stuks a 41,5 gr'),
    ('Duyvis Pinda''s gezouten nootjes', cat_food_id, 'doos 20 zakjes a 60 gr'),
    ('Kaasblokjes - jong', cat_food_id, 'per bak'),
    ('Kaasblokjes - oud', cat_food_id, 'per bak'),
    ('Komijn - blokjes', cat_food_id, 'per bak'),
    ('Daelmans Mini stroopwafel blikken', cat_food_id, 'per doos 48 stuks a 400g'),
    ('Daelmans Mini stroopwafels en gezoete pindas Emmer 5 kilo', cat_food_id, 'per emmer 5 kilo'),
    ('Peijnenburg ontbijtkoek Naturel Emmer 750 gram', cat_food_id, 'per emmer 750 gr'),
    ('Pickwick Theezakjes Earl Grey Met Envelop Pak 100 zakjes x 2 gr', cat_food_id, 'per 100 stuks x 2g'),
    ('Pickwick Theezakjes Lemon Met Envelop Pak 100 zakjes x 2 gr', cat_food_id, 'per 100 stuks x 2g'),
    ('Pickwick Theezakjes Bosvruchten Met Envelop Pak 100 zakjes x 2 gr', cat_food_id, 'per 100 stuks x 2g'),
    ('Apollo Gemberkoek 6x45gr', cat_food_id, 'per 6 stuks x 45 gr'),
    ('Apollo Appelkoek', cat_food_id, 'per box'),
    ('Heks Spekkoek 570gr', cat_food_id, 'per box')
  ON CONFLICT (name, category_id) DO NOTHING;

  -- STROMMA / SNACKS (Other)
  INSERT INTO items (name, category_id, pack_size) VALUES
    ('Oud hollandse candy''s', cat_other_id, 'doos 60 stuks a 150g'),
    ('Stroopwafel zakje', cat_other_id, 'doos 60 stuks a 150g'),
    ('Stroopwafel koker yellow box', cat_other_id, 'doos 60 stuks a 150g'),
    ('Pretzel', cat_other_id, 'doos 60 stuks a 150g'),
    ('Huismix', cat_other_id, 'doos 60 stuks a 150g')
  ON CONFLICT (name, category_id) DO NOTHING;

  -- KAAS (Cheese)
  INSERT INTO items (name, category_id, pack_size) VALUES
    ('Cubes Mature / 4–6 months', cat_cheese_id, 'per 12 x 135g'),
    ('Cheese', cat_cheese_id, '-')
  ON CONFLICT (name, category_id) DO NOTHING;
END $$;

-- Create shop-item assignments using subqueries
-- Winkel Rijks items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Winkel Rijks'),
  id
FROM items
WHERE name IN (
  'OLA Raket', 'OLA Donut', 'OLA Dracula', 'OLA Super Twister', 'OLA Magnum Classic', 
  'OLA Magnum Almond', 'OLA Magnum White', 'OLA Cornetto Classico',
  'Heineken blik 33CL', 'Heineken blik 0,0% 33CL', 'Desperados 33CL',
  'La Croisade chardonnay grenache 25CL', 'La Croisade merlot rouge 25CL', 'La Croisade rosé 25CL',
  'Lisetto Prosecco Klein flesje 20CL', 'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL',
  'Sourcy Rood pet 50CL', 'Sourcy Vitamin Water Braam Acai 0% 50CL',
  'Sourcy Vitamin Water Druif/Citroen 0% 50CL', 'Sourcy Vitamin Water Lemon/Mango Guave 0% 50CL',
  'Rivella 50CL', 'Ranja fruitmix aardbei/framboos 33CL',
  'Lipton Ice Tea Sparkling petfles 50CL', 'Lipton Ice Tea Peach petfles 50CL',
  'Pepsi Regular 50CL', 'Pepsi petfles max 50CL', 'Seven Up suikervrij 50CL',
  'Sisi suikervrij 50CL', 'Rockstar original/regular/suikervrij (blik) 25CL',
  'Lay''s zakje chips naturel/paprika/bolognese', 'Pringles Original/Sourcream/Hot',
  'Haribo Starmix 75 gram', 'Daelmans stroopwafels jumbo single',
  'Milky way single reep', 'M&M''s pinda single', 'Mars single reep',
  'Snickers single reep', 'Twix single reep', 'KitKat chocobar',
  'Oud hollandse candy''s', 'Stroopwafel zakje', 'Stroopwafel koker yellow box',
  'Pretzel', 'Huismix',
  'Cubes Mature / 4–6 months'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- Ponton Rijks items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Ponton Rijks'),
  id
FROM items
WHERE name IN (
  'Heineken blik 33CL', 'Heineken blik 0,0% 33CL', 'Desperados 33CL',
  'La Croisade chardonnay grenache 25CL', 'La Croisade merlot rouge 25CL', 'La Croisade rosé 25CL',
  'Lisetto Prosecco Klein flesje 20CL', 'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL',
  'Sourcy Rood pet 50CL', 'Sourcy Vitamin Water Braam Acai 0% 50CL',
  'Sourcy Vitamin Water Druif/Citroen 0% 50CL', 'Sourcy Vitamin Water Mango Guave 0% 50CL',
  'Rivella 50CL', 'Ranja fruitmix aardbei/framboos 33CL',
  'Lipton Ice Tea Sparkling petfles 50CL', 'Lipton Ice Tea Peach/green Zero 50CL',
  'Pepsi regular 50CL', 'Pepsi petfles max 50CL', 'Seven Up suikervrij 50CL',
  'Sisi suikervrij 50CL', 'Rockstar original/regular/suikervrij (blik) 25CL'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- ARK Rijks items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'ARK Rijks'),
  id
FROM items
WHERE name IN (
  'Segura Viudas Cava Brut Fles 75 cl', 'Marula Rose 75 cl', 'Lisetto Prosecco Spumante Fles 75 cl',
  'Laroche Wine Chardonnay Fles 75 cl', 'Laroche Rood Merlot Fles 75 cl', 'Laroche Rosé Fles 75 cl',
  'La Croisade Chardonnay grenache 75cl', 'La Croisade Merlot rouge 75cl', 'La Croisade rosé 75cl',
  'Heineken Pilsener Star Bottle krat', 'Heineken 0,0% krat',
  'Sourcy Rood mineraalwater 20 cl fles krat', 'Sourcy Blauw mineraalwater koolzuurvrij fles 20 cl krat',
  'Pepsi Regular cola 20 cl fles krat', 'Pepsi Max cola 20 cl fles krat',
  '7 Up Free 20 cl fles krat', 'Sisi Suikerwitte Sinas 20cl fles krat',
  'Lipton Ice tea green 20 cl fles krat', 'Royal Club Cassisappael 20 cl fles krat',
  'Royal Club Apfelsap 20 cl fles krat', 'Sourcy Natuurmin. mineraalwater koolzuurvrij 75 cl',
  'Sourcy Rood mineraalwater 75 cl',
  'Lay''s zakje chips naturel/paprika/bolognese', 'Pringles Original/Sourcream/Hot',
  'Haribo Starmix 75 gram', 'Daelmans stroopwafels jumbo single',
  'Milky way single reep', 'M&M''s pinda single', 'Mars single reep',
  'Snickers single reep', 'Twix single reep', 'KitKat chocobar',
  'Duyvis Pinda''s gezouten nootjes',
  'Kaasblokjes - jong', 'Kaasblokjes - oud', 'Komijn - blokjes',
  'Daelmans Mini stroopwafel blikken', 'Daelmans Mini stroopwafels en gezoete pindas Emmer 5 kilo',
  'Peijnenburg ontbijtkoek Naturel Emmer 750 gram',
  'Pickwick Theezakjes Earl Grey Met Envelop Pak 100 zakjes x 2 gr',
  'Pickwick Theezakjes Lemon Met Envelop Pak 100 zakjes x 2 gr',
  'Pickwick Theezakjes Bosvruchten Met Envelop Pak 100 zakjes x 2 gr',
  'Apollo Gemberkoek 6x45gr', 'Apollo Appelkoek', 'Heks Spekkoek 570gr'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- Leidse items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'Leidse'),
  id
FROM items
WHERE name IN (
  'OLA Raket', 'OLA Donut', 'OLA Dracula', 'OLA Super Twister', 'OLA Magnum Classic',
  'OLA Magnum Almond', 'OLA Magnum White', 'OLA Cornetto Classico',
  'Heineken blik 33CL', 'Heineken blik 0,0% 33CL', 'Desperados 33CL',
  'La Croisade chardonnay grenache 25CL', 'La Croisade merlot rouge 25CL', 'La Croisade rosé 25CL',
  'Lisetto Prosecco Klein flesje 20CL', 'Sourcy Mineraalwater blauw koolzuurvrij pet 50CL',
  'Sourcy Rood pet 50CL', 'Sourcy Vitamin Water Braam Acai 0% 50CL',
  'Sourcy Vitamin Water Druif/Citroen 0% 50CL', 'Sourcy Vitamin Water Mango Guave 0% 50CL',
  'Rivella 50CL', 'Ranja fruitmix aardbei/framboos 33CL',
  'Lipton Ice Tea Sparkling petfles 50CL', 'Lipton Ice Tea Peach/green Zero 50CL',
  'Pepsi regular 50CL', 'Pepsi petfles max 50CL', 'Seven Up suikervrij 50CL',
  'Sisi suikervrij 50CL', 'Rockstar original/regular/suikervrij (blik) 25CL',
  'Lay''s zakje chips naturel/paprika/bolognese', 'Pringles Original/Sourcream/Hot',
  'Haribo Starmix 75 gram', 'Daelmans stroopwafels jumbo single',
  'Milky way single reep', 'M&M''s pinda single', 'Mars single reep',
  'Snickers single reep', 'Twix single reep', 'KitKat chocobar',
  'Duyvis Pinda''s gezouten nootjes',
  'Oud hollandse candy''s', 'Stroopwafel zakje', 'Stroopwafel koker yellow box',
  'Pretzel', 'Huismix',
  'Cheese', 'Cubes Mature / 4–6 months'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

