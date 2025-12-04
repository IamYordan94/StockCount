-- Diagnostic SQL to check shops and user roles
-- Run this in Supabase SQL Editor to diagnose why shops aren't showing

-- 1. Check if shops exist
SELECT COUNT(*) as shop_count FROM shops;
SELECT id, name, created_at FROM shops ORDER BY name LIMIT 10;

-- 2. Check your user role (replace YOUR_USER_ID with your actual user ID from auth.users)
-- First, get your user ID:
SELECT id, email FROM auth.users ORDER BY created_at DESC LIMIT 5;

-- Then check your role (replace 'YOUR_USER_ID_HERE' with the ID from above):
SELECT * FROM user_roles WHERE id = 'YOUR_USER_ID_HERE';

-- 3. Check RLS policies on shops table
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies 
WHERE tablename = 'shops'
ORDER BY policyname;

-- 4. Test if you can see shops (this will show if RLS is blocking)
-- Replace 'YOUR_USER_ID_HERE' with your user ID
SET LOCAL role = authenticated;
SET LOCAL request.jwt.claim.sub = 'YOUR_USER_ID_HERE';
SELECT COUNT(*) as visible_shops FROM shops;

-- 5. Check for duplicate items
SELECT name, category, COUNT(*) as count 
FROM items 
GROUP BY name, category 
HAVING COUNT(*) > 1
ORDER BY count DESC;

-- 6. To fix duplicate items (run this if you see duplicates):
-- First, see which items are duplicated:
-- SELECT id, name, category, created_at 
-- FROM items 
-- WHERE (name, category) IN (
--   SELECT name, category 
--   FROM items 
--   GROUP BY name, category 
--   HAVING COUNT(*) > 1
-- )
-- ORDER BY name, category, created_at;

-- Then delete duplicates, keeping the oldest one:
-- DELETE FROM items
-- WHERE id IN (
--   SELECT id FROM (
--     SELECT id, 
--            ROW_NUMBER() OVER (PARTITION BY name, category ORDER BY created_at) as rn
--     FROM items
--   ) t
--   WHERE rn > 1
-- );

