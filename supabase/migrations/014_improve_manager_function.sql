-- Improved version of is_manager() function
-- This version ensures the function can bypass RLS properly

-- First, drop all policies that depend on the function
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

-- Now drop and recreate the function with explicit permissions
-- SECURITY DEFINER runs with the privileges of the function owner (postgres)
-- This allows it to bypass RLS on user_roles
DROP FUNCTION IF EXISTS is_manager();

CREATE OR REPLACE FUNCTION is_manager()
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
BEGIN
  -- This query will bypass RLS because SECURITY DEFINER runs as postgres
  RETURN EXISTS (
    SELECT 1 
    FROM public.user_roles 
    WHERE user_id = auth.uid() 
    AND role = 'manager'
  );
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION is_manager() TO authenticated;

-- Recreate all the policies using the improved function
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

