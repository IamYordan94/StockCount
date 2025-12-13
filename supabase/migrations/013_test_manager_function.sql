-- Test script to verify is_manager() function works
-- Run this in Supabase SQL Editor to test if the function is working

-- First, check if the function exists
SELECT proname, prosrc 
FROM pg_proc 
WHERE proname = 'is_manager';

-- Test the function (replace 'YOUR_USER_ID' with your actual user ID from auth.users)
-- You can get your user ID by running: SELECT id, email FROM auth.users;
SELECT 
  auth.uid() as current_user_id,
  is_manager() as is_manager_result,
  (SELECT role FROM user_roles WHERE user_id = auth.uid()) as user_role;

-- If you're logged in via Supabase dashboard, you can also test directly:
-- SELECT is_manager();

