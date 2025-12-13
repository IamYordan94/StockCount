-- Insert items and shop-item assignments for CS Oost shop
-- This migration adds all items from CS Oost
-- Uses subqueries to resolve category and shop IDs by name
-- Uses ON CONFLICT to handle duplicate items that may exist from other shops

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

  -- Insert new items (using ON CONFLICT to handle duplicates)
  -- DRANK CATERING (Drinks)
  INSERT INTO items (name, category_id, pack_size) VALUES
    -- New wines
    ('Marival Rose 75 cl', cat_drinks_id, 'per doos 6 stuks'),
    ('Laroche Wit Chardonnay Fles 75 cl', cat_drinks_id, 'fles per doos 6 stuks'),
    ('Villa Luisa Pinot Grigio 75cl', cat_drinks_id, 'per doos 6 stuks'),
    -- New soft drinks
    ('Minute Maid Appel', cat_drinks_id, 'per krat 24 stuks'),
    ('Sourcy Natuurlijk mineraalwater koolzuurvrij fles 20 cl krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Sisi Suikervrije Sinas 20cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    ('Royal Club Sinaasappelsap 20 cl fles krat', cat_drinks_id, 'per krat 28 stuks'),
    -- PRIDE EVENT drinks
    ('Amstel Rosé', cat_drinks_id, 'per krat 24 stuks'),
    ('Floralba Pinot Grigio Blush Rose', cat_drinks_id, 'per doos 6 stuks')
  ON CONFLICT (name, category_id) DO NOTHING;

  -- ETEN CATERING (Food)
  INSERT INTO items (name, category_id, pack_size) VALUES
    -- New snacks
    ('Daelmans Mini stroopwafel blokzak', cat_food_id, 'per doos 6 stuks a 400g'),
    ('Daelmans Mini stroopwafels Doos 2,5 kilo', cat_food_id, 'per doos 200 stuks a 8g'),
    ('Leev Stroopwafel bio glutenvrij', cat_food_id, 'per 16 stuks a 60g'),
    ('Daendels Hotmix van rijstzoutjes en gecoate pinda''s Emmer', cat_food_id, 'per emmer 5 kilo'),
    ('Daendels Roomboter kaasvlinders Emmer 750 gram', cat_food_id, 'per emmer 750 gram'),
    -- New tea
    ('Pickwick Theezakjes Green Lemon Met Envelop Pak 100 zakjes', cat_food_id, 'per 100 stuks x 2g'),
    -- New spices
    ('Apollo Zwarte pepermolen', cat_food_id, 'per 6 stuks x 45 gr'),
    ('Apollo Zeezoutmolen', cat_food_id, 'per 6 stuks'),
    ('Hekos Spekkoek 570gr', cat_food_id, 'per box')
  ON CONFLICT (name, category_id) DO NOTHING;
END $$;

-- Create shop-item assignments for CS Oost
-- DRANK CATERING items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'CS Oost'),
  id
FROM items
WHERE name IN (
  -- Wines
  'Segura Viudas Cava Brut Fles 75 cl',
  'Marival Rose 75 cl',
  'Lisetto Prosecco Spumante Fles 75 cl',
  'Laroche Wit Chardonnay Fles 75 cl',
  'Laroche Rood Merlot Fles 75 cl',
  'Laroche Rose Fles 75 cl',
  'La Croisade Chardonnay grenache 75cl',
  'La Croisade Merlot rouge 75cl',
  'La Croisade rosé 75cl',
  'Villa Luisa Pinot Grigio 75cl',
  -- Beers
  'Heineken Pilsener Star Bottle krat',
  'Heineken 0,0% krat',
  -- Soft drinks & water
  'Minute Maid Appel',
  'Sourcy Rood mineraalwater 20 cl fles krat',
  'Sourcy Natuurlijk mineraalwater koolzuurvrij fles 20 cl krat',
  'Pepsi Regular cola 20 cl fles krat',
  'Pepsi Max cola 20 cl fles krat',
  '7 Up Free 20 cl fles krat',
  'Sisi Suikervrije Sinas 20cl fles krat',
  'Lipton Ice tea green 20 cl fles krat',
  'Royal Club Sinaasappelsap 20 cl fles krat',
  'Royal Club Appelsap 20 cl fles krat',
  'Sourcy Natuurmin. mineraalwater koolzuurvrij 75 cl',
  'Sourcy Rood mineraalwater 75 cl',
  -- PRIDE EVENT drinks
  'Heineken blik 33CL',
  'Amstel Rosé',
  'Floralba Pinot Grigio Blush Rose'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

-- ETEN CATERING items
INSERT INTO shop_items (shop_id, item_id)
SELECT 
  (SELECT id FROM shops WHERE name = 'CS Oost'),
  id
FROM items
WHERE name IN (
  -- Cheese
  'Kaasblokjes - jong',
  'Kaasblokjes - oud',
  'Komijn - blokjes',
  -- Snacks
  'Daelmans Mini stroopwafel blikken',
  'Daelmans Mini stroopwafel blokzak',
  'Daelmans Mini stroopwafels Doos 2,5 kilo',
  'Leev Stroopwafel bio glutenvrij',
  'Daendels Hotmix van rijstzoutjes en gecoate pinda''s Emmer',
  'Daendels Roomboter kaasvlinders Emmer 750 gram',
  -- Tea
  'Pickwick Theezakjes Earl Grey Met Envelop Pak 100 zakjes x 2 gr',
  'Pickwick Theezakjes Green Lemon Met Envelop Pak 100 zakjes',
  'Pickwick Theezakjes Bosvruchten Met Envelop Pak 100 zakjes x 2 gr',
  -- Spices & other
  'Apollo Gemberkoek 6x45gr',
  'Apollo Zwarte pepermolen',
  'Apollo Zeezoutmolen',
  'Heks Spekkoek 570gr',
  'Hekos Spekkoek 570gr'
)
ON CONFLICT (shop_id, item_id) DO NOTHING;

