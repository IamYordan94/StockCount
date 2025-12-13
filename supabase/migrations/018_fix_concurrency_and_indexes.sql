-- Migration 018: Fix concurrency issues and add missing indexes/triggers
-- This migration adds:
-- 1. Automatic updated_at triggers for all tables
-- 2. Missing indexes for better query performance
-- 3. Ensures data integrity for concurrent operations

-- ============================================================================
-- 1. Create function to update updated_at timestamp
-- ============================================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 2. Add updated_at triggers for all tables that have updated_at column
-- ============================================================================

-- Categories
DROP TRIGGER IF EXISTS update_categories_updated_at ON categories;
CREATE TRIGGER update_categories_updated_at
  BEFORE UPDATE ON categories
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Shops
DROP TRIGGER IF EXISTS update_shops_updated_at ON shops;
CREATE TRIGGER update_shops_updated_at
  BEFORE UPDATE ON shops
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Items
DROP TRIGGER IF EXISTS update_items_updated_at ON items;
CREATE TRIGGER update_items_updated_at
  BEFORE UPDATE ON items
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Stock Counts
DROP TRIGGER IF EXISTS update_stock_counts_updated_at ON stock_counts;
CREATE TRIGGER update_stock_counts_updated_at
  BEFORE UPDATE ON stock_counts
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- User Roles
DROP TRIGGER IF EXISTS update_user_roles_updated_at ON user_roles;
CREATE TRIGGER update_user_roles_updated_at
  BEFORE UPDATE ON user_roles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- 3. Add missing indexes for better query performance
-- ============================================================================

-- Index for querying counts by user (counted_by)
CREATE INDEX IF NOT EXISTS idx_stock_counts_counted_by 
  ON stock_counts(counted_by);

-- Index for sorting/filtering by update time
CREATE INDEX IF NOT EXISTS idx_stock_counts_updated_at 
  ON stock_counts(updated_at DESC);

-- Composite index for common query pattern: session + shop
CREATE INDEX IF NOT EXISTS idx_stock_counts_session_shop 
  ON stock_counts(session_id, shop_id);

-- Index for stock_count_sessions status (for filtering active/completed)
CREATE INDEX IF NOT EXISTS idx_stock_count_sessions_status 
  ON stock_count_sessions(status);

-- Index for stock_count_sessions created_at (for sorting)
CREATE INDEX IF NOT EXISTS idx_stock_count_sessions_created_at 
  ON stock_count_sessions(created_at DESC);

-- ============================================================================
-- 4. Add comment explaining the UNIQUE constraint behavior
-- ============================================================================
COMMENT ON CONSTRAINT stock_counts_session_id_shop_id_item_id_key ON stock_counts IS 
  'Ensures only one count per item per shop per session. UPSERT operations will update existing rows instead of creating duplicates.';

-- ============================================================================
-- 5. Verify RLS policies support UPSERT
-- ============================================================================
-- Note: UPSERT operations work with existing RLS policies:
-- - INSERT: "Users can insert their own counts" (WITH CHECK auth.uid() = counted_by)
-- - UPDATE: "Users can update their own counts" OR "Managers can update any counts"
-- When UPSERT encounters a conflict, it performs UPDATE which is checked against UPDATE policies.
-- This ensures users can only update counts they created (unless they're managers).

