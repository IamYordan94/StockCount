-- Fix infinite recursion in user_roles RLS policies
-- The manager policy was checking user_roles table which caused recursion
-- This migration fixes the policies to prevent the circular dependency

-- Drop the problematic policies
DROP POLICY IF EXISTS "Users can view their own role" ON user_roles;
DROP POLICY IF EXISTS "Managers can view all roles" ON user_roles;
DROP POLICY IF EXISTS "Managers can manage roles" ON user_roles;

-- Recreate the simple policy that doesn't cause recursion
-- Users can always read their own role (no recursion - only checks auth.uid())
CREATE POLICY "Users can view their own role" ON user_roles 
  FOR SELECT 
  USING (auth.uid() = user_id);

-- Note: Manager operations (viewing all users, managing roles) are handled
-- via API routes that use the service role key, which bypasses RLS.
-- This prevents the infinite recursion issue.

