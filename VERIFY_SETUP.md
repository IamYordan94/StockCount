# Verify Your Setup

## ✅ Migration Already Complete!

The error "relation 'categories' already exists" means:
- ✅ The migration ran successfully the first time
- ✅ All tables are created
- ✅ You don't need to run it again

## Next Steps: Check Your Setup

### 1. Verify Tables Were Created

In Supabase:
1. Go to **Table Editor** (left sidebar)
2. You should see these tables:
   - ✅ categories
   - ✅ shops
   - ✅ items
   - ✅ shop_items
   - ✅ stock_count_sessions
   - ✅ stock_counts
   - ✅ user_roles
   - ✅ user_shop_assignments

### 2. Check Default Categories

1. Click on **categories** table
2. You should see 4 categories:
   - Food
   - Drinks
   - Cheese
   - Other

### 3. Set Your Role as Manager (IMPORTANT!)

If you haven't done this yet:

1. Go to **Authentication** → **Users**
2. Find your user (the email you signed up with)
3. Copy the **User ID** (it's a UUID like: `123e4567-e89b-12d3-a456-426614174000`)
4. Go to **SQL Editor**
5. Run this (replace with your actual User ID):

```sql
INSERT INTO user_roles (user_id, role) 
VALUES ('your-user-id-here', 'manager')
ON CONFLICT (user_id) DO UPDATE SET role = 'manager';
```

The `ON CONFLICT` part means: if you already have a role, it will update it to manager.

### 4. Refresh Your App

1. Go to http://localhost:3000
2. Log out and log back in (or just refresh)
3. You should now see the manager dashboard with:
   - Stock Count Sessions
   - Products
   - Users
   - Shops

## If You Still See Empty Dashboard

Check the browser console (F12) for errors. Common issues:

1. **Wrong environment variables** - Check `.env.local` has correct keys
2. **Not logged in as manager** - Run the SQL above to set your role
3. **Database connection issue** - Check Supabase project is active

## Ready to Start Using?

Once you see the manager dashboard:

1. **Add Shops**: Dashboard → Shops → Add all 11 shops
2. **Add Products**: Dashboard → Products → Add your items
3. **Assign Items**: Dashboard → Products → "Assign Items to Shops"
4. **Create Session**: Dashboard → Stock Count Sessions → Create New Session

