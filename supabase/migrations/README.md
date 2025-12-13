# Database Migrations

## Running Migrations

1. Go to your Supabase project dashboard
2. Navigate to SQL Editor
3. Copy and paste the contents of `001_initial_schema.sql`
4. Run the query

This will create:
- All necessary tables (categories, shops, items, shop_items, stock_count_sessions, stock_counts, user_roles, user_shop_assignments)
- Row Level Security (RLS) policies
- Default categories (Food, Drinks, Cheese, Other)
- Indexes for performance

## Creating Your First Manager

After running the migration and creating your first user account:

1. Go to Supabase Dashboard → Authentication → Users
2. Find your user and copy the User ID
3. Go to SQL Editor and run:
```sql
INSERT INTO user_roles (user_id, role) 
VALUES ('your-user-id-here', 'manager');
```

Replace `'your-user-id-here'` with your actual User ID.

