-- Migration 009: Allow users to update their own must_change_password flag
-- This is needed for the password change flow

-- Allow users to update their own must_change_password flag
-- This policy allows users to update only their own user_roles record
DROP POLICY IF EXISTS "Users can update their own password flag" ON user_roles;
CREATE POLICY "Users can update their own password flag" ON user_roles
  FOR UPDATE 
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

