-- Session User Assignments table
-- Links users to sessions so managers can assign specific users to count for each session

CREATE TABLE IF NOT EXISTS session_user_assignments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id UUID REFERENCES stock_count_sessions(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(session_id, user_id)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_session_user_assignments_session_id ON session_user_assignments(session_id);
CREATE INDEX IF NOT EXISTS idx_session_user_assignments_user_id ON session_user_assignments(user_id);

-- Enable Row Level Security
ALTER TABLE session_user_assignments ENABLE ROW LEVEL SECURITY;

-- RLS Policies for session_user_assignments
-- Managers can view all assignments
CREATE POLICY "Managers can view all session assignments"
  ON session_user_assignments
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.user_id = auth.uid()
      AND user_roles.role = 'manager'
    )
  );

-- Managers can manage all assignments
CREATE POLICY "Managers can manage session assignments"
  ON session_user_assignments
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_roles.user_id = auth.uid()
      AND user_roles.role = 'manager'
    )
  );

-- Users can view their own assignments
CREATE POLICY "Users can view their own session assignments"
  ON session_user_assignments
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

