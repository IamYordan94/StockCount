-- Fix duplicate items - keeps the oldest item, deletes newer duplicates
-- Run this in Supabase SQL Editor

-- First, see what will be deleted (preview):
SELECT 
  id,
  name,
  category,
  packaging_unit_description,
  main_category,
  created_at,
  ROW_NUMBER() OVER (PARTITION BY name, category ORDER BY created_at) as duplicate_rank
FROM items
WHERE (name, category) IN (
  SELECT name, category 
  FROM items 
  GROUP BY name, category 
  HAVING COUNT(*) > 1
)
ORDER BY name, category, created_at;

-- If the preview looks correct, uncomment and run this to delete duplicates:
-- DELETE FROM items
-- WHERE id IN (
--   SELECT id FROM (
--     SELECT 
--       id,
--       ROW_NUMBER() OVER (PARTITION BY name, category ORDER BY created_at) as rn
--     FROM items
--   ) t
--   WHERE rn > 1
-- );

-- After deleting duplicates, verify:
-- SELECT name, category, COUNT(*) as count 
-- FROM items 
-- GROUP BY name, category 
-- HAVING COUNT(*) > 1;

