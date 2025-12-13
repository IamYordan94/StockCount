-- Add name field to user_roles table
-- This allows storing a display name for each user

ALTER TABLE user_roles 
ADD COLUMN IF NOT EXISTS name TEXT;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_user_roles_name ON user_roles(name);

-- Add comment
COMMENT ON COLUMN user_roles.name IS 'Display name for the user (shown instead of email)';

