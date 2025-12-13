-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Categories table
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Shops table
CREATE TABLE shops (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Items table
CREATE TABLE items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
  pack_size TEXT NOT NULL, -- e.g., "12 per pack", "500g", etc.
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(name, category_id)
);

-- Shop Items junction table (items available per shop)
CREATE TABLE shop_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  shop_id UUID REFERENCES shops(id) ON DELETE CASCADE,
  item_id UUID REFERENCES items(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(shop_id, item_id)
);

-- Stock Count Sessions table
CREATE TABLE stock_count_sessions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'active', -- 'active', 'completed', 'archived'
  created_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,
  UNIQUE(name)
);

-- Stock Counts table (actual count data)
CREATE TABLE stock_counts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id UUID REFERENCES stock_count_sessions(id) ON DELETE CASCADE,
  shop_id UUID REFERENCES shops(id) ON DELETE CASCADE,
  item_id UUID REFERENCES items(id) ON DELETE CASCADE,
  boxes INTEGER NOT NULL DEFAULT 0,
  singles INTEGER NOT NULL DEFAULT 0,
  counted_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(session_id, shop_id, item_id)
);

-- User Roles table (extends auth.users)
CREATE TABLE user_roles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  role TEXT NOT NULL DEFAULT 'employee', -- 'manager', 'employee'
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User Shop Assignments table
CREATE TABLE user_shop_assignments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  shop_id UUID REFERENCES shops(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, shop_id)
);

-- Create indexes for better performance
CREATE INDEX idx_shop_items_shop_id ON shop_items(shop_id);
CREATE INDEX idx_shop_items_item_id ON shop_items(item_id);
CREATE INDEX idx_stock_counts_session_id ON stock_counts(session_id);
CREATE INDEX idx_stock_counts_shop_id ON stock_counts(shop_id);
CREATE INDEX idx_stock_counts_item_id ON stock_counts(item_id);
CREATE INDEX idx_user_shop_assignments_user_id ON user_shop_assignments(user_id);
CREATE INDEX idx_user_shop_assignments_shop_id ON user_shop_assignments(shop_id);
CREATE INDEX idx_items_category_id ON items(category_id);

-- Enable Row Level Security
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE shops ENABLE ROW LEVEL SECURITY;
ALTER TABLE items ENABLE ROW LEVEL SECURITY;
ALTER TABLE shop_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE stock_count_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE stock_counts ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_shop_assignments ENABLE ROW LEVEL SECURITY;

-- RLS Policies
-- Categories: Everyone can read, only managers can write
CREATE POLICY "Categories are viewable by everyone" ON categories FOR SELECT USING (true);
CREATE POLICY "Categories are editable by managers" ON categories FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- Shops: Everyone can read, only managers can write
CREATE POLICY "Shops are viewable by everyone" ON shops FOR SELECT USING (true);
CREATE POLICY "Shops are editable by managers" ON shops FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- Items: Everyone can read, only managers can write
CREATE POLICY "Items are viewable by everyone" ON items FOR SELECT USING (true);
CREATE POLICY "Items are editable by managers" ON items FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- Shop Items: Everyone can read, only managers can write
CREATE POLICY "Shop items are viewable by everyone" ON shop_items FOR SELECT USING (true);
CREATE POLICY "Shop items are editable by managers" ON shop_items FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- Stock Count Sessions: Everyone can read, only managers can create/update
CREATE POLICY "Sessions are viewable by everyone" ON stock_count_sessions FOR SELECT USING (true);
CREATE POLICY "Sessions are editable by managers" ON stock_count_sessions FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- Stock Counts: Users can read their own counts or all if manager, can insert/update their own
CREATE POLICY "Stock counts are viewable by everyone" ON stock_counts FOR SELECT USING (true);
CREATE POLICY "Users can insert their own counts" ON stock_counts FOR INSERT WITH CHECK (auth.uid() = counted_by);
CREATE POLICY "Users can update their own counts" ON stock_counts FOR UPDATE USING (auth.uid() = counted_by);
CREATE POLICY "Managers can update any counts" ON stock_counts FOR UPDATE USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- User Roles: Users can read their own role, managers can read all
CREATE POLICY "Users can view their own role" ON user_roles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Managers can view all roles" ON user_roles FOR SELECT USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);
CREATE POLICY "Managers can manage roles" ON user_roles FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- User Shop Assignments: Users can read their own assignments, managers can read all
CREATE POLICY "Users can view their own assignments" ON user_shop_assignments FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Managers can view all assignments" ON user_shop_assignments FOR SELECT USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);
CREATE POLICY "Managers can manage assignments" ON user_shop_assignments FOR ALL USING (
  EXISTS (SELECT 1 FROM user_roles WHERE user_id = auth.uid() AND role = 'manager')
);

-- Insert default categories
INSERT INTO categories (name) VALUES 
  ('Food'),
  ('Drinks'),
  ('Cheese'),
  ('Other');

