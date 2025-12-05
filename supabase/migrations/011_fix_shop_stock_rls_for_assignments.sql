-- Migration 011: Fix shop_stock RLS policy to use shop_assignments instead of user_roles.shop_id
-- This allows staff users to view and update stock for shops they're assigned to

-- Drop the old policy that checks user_roles.shop_id
DROP POLICY IF EXISTS "Users can view their shop stock" ON shop_stock;
DROP POLICY IF EXISTS "Users can update their shop stock" ON shop_stock;

-- Create new policy for viewing stock that checks shop_assignments
CREATE POLICY "Staff can view assigned shop stock" ON shop_stock
  FOR SELECT USING (
    -- Admins can see all stock (handled by separate policy)
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.id = auth.uid() AND user_roles.role = 'admin'
    )
    OR
    -- Staff can see stock for shops they're assigned to via shop_assignments
    EXISTS (
      SELECT 1 FROM shop_assignments
      WHERE shop_assignments.user_id = auth.uid()
        AND shop_assignments.shop_id = shop_stock.shop_id
        AND shop_assignments.active = true
    )
    OR
    -- Backward compatibility: check user_roles.shop_id (for old assignments)
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.id = auth.uid() 
        AND user_roles.shop_id = shop_stock.shop_id
        AND user_roles.role IN ('staff', 'manager')
    )
  );

-- Create new policy for updating stock that checks shop_assignments
CREATE POLICY "Staff can update assigned shop stock" ON shop_stock
  FOR UPDATE USING (
    -- Admins can update all stock (handled by separate policy if exists)
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.id = auth.uid() AND user_roles.role = 'admin'
    )
    OR
    -- Staff can update stock for shops they're assigned to via shop_assignments
    EXISTS (
      SELECT 1 FROM shop_assignments
      WHERE shop_assignments.user_id = auth.uid()
        AND shop_assignments.shop_id = shop_stock.shop_id
        AND shop_assignments.active = true
    )
    OR
    -- Backward compatibility: check user_roles.shop_id (for old assignments)
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.id = auth.uid() 
        AND user_roles.shop_id = shop_stock.shop_id
        AND user_roles.role IN ('staff', 'manager')
    )
  );

