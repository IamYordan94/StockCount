-- Fix RLS policies for all tables by creating a helper function
-- This function uses SECURITY DEFINER to bypass RLS when checking manager status

-- Create a function to check if current user is a manager
-- SECURITY DEFINER allows it to bypass RLS on user_roles table
CREATE OR REPLACE FUNCTION is_manager()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 
    FROM user_roles 
    WHERE user_id = auth.uid() 
    AND role = 'manager'
  );
$$;

-- Drop existing policies that check manager status
DROP POLICY IF EXISTS "Categories are editable by managers" ON categories;
DROP POLICY IF EXISTS "Shops are editable by managers" ON shops;
DROP POLICY IF EXISTS "Items are editable by managers" ON items;
DROP POLICY IF EXISTS "Shop items are editable by managers" ON shop_items;
DROP POLICY IF EXISTS "Sessions are editable by managers" ON stock_count_sessions;
DROP POLICY IF EXISTS "Managers can update any counts" ON stock_counts;
DROP POLICY IF EXISTS "Managers can view all roles" ON user_roles;
DROP POLICY IF EXISTS "Managers can manage roles" ON user_roles;
DROP POLICY IF EXISTS "Managers can view all assignments" ON user_shop_assignments;
DROP POLICY IF EXISTS "Managers can manage assignments" ON user_shop_assignments;

-- Recreate policies using the helper function
-- Categories: Managers can insert, update, delete
CREATE POLICY "Categories are editable by managers" ON categories 
  FOR ALL 
  USING (is_manager())
  WITH CHECK (is_manager());

-- Shops: Managers can insert, update, delete
CREATE POLICY "Shops are editable by managers" ON shops 
  FOR ALL 
  USING (is_manager())
  WITH CHECK (is_manager());

-- Items: Managers can insert, update, delete
CREATE POLICY "Items are editable by managers" ON items 
  FOR ALL 
  USING (is_manager())
  WITH CHECK (is_manager());

-- Shop Items: Managers can insert, update, delete
CREATE POLICY "Shop items are editable by managers" ON shop_items 
  FOR ALL 
  USING (is_manager())
  WITH CHECK (is_manager());

-- Stock Count Sessions: Managers can insert, update, delete
CREATE POLICY "Sessions are editable by managers" ON stock_count_sessions 
  FOR ALL 
  USING (is_manager())
  WITH CHECK (is_manager());

-- Stock Counts: Managers can update any counts
CREATE POLICY "Managers can update any counts" ON stock_counts 
  FOR UPDATE 
  USING (is_manager());

-- User Roles: Managers can view all and manage all
CREATE POLICY "Managers can view all roles" ON user_roles 
  FOR SELECT 
  USING (is_manager());

CREATE POLICY "Managers can manage roles" ON user_roles 
  FOR ALL 
  USING (is_manager())
  WITH CHECK (is_manager());

-- User Shop Assignments: Managers can view all and manage all
CREATE POLICY "Managers can view all assignments" ON user_shop_assignments 
  FOR SELECT 
  USING (is_manager());

CREATE POLICY "Managers can manage assignments" ON user_shop_assignments 
  FOR ALL 
  USING (is_manager())
  WITH CHECK (is_manager());

