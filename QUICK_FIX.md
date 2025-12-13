# Quick Fix: Empty Dashboard Issue

## The Problem
Your dashboard is empty because the database tables haven't been created yet. The app is trying to read from tables that don't exist in Supabase.

## The Solution: Run the Database Migration

### Step 1: Go to Supabase Dashboard
1. Open https://supabase.com
2. Log in and select your project

### Step 2: Open SQL Editor
1. Click **SQL Editor** in the left sidebar
2. Click **New query**

### Step 3: Run the Migration
1. Open the file: `supabase/migrations/001_initial_schema.sql` in your code editor
2. Copy **ALL** the contents (the entire file)
3. Paste it into the Supabase SQL Editor
4. Click **Run** (or press Ctrl+Enter)

### Step 4: Verify It Worked
You should see a success message. The migration creates:
- ✅ All tables (shops, items, categories, etc.)
- ✅ Security policies
- ✅ Default categories (Food, Drinks, Cheese, Other)

### Step 5: Set Your Role as Manager
1. In Supabase, go to **Authentication** → **Users**
2. Find your user and copy the **User ID** (it's a UUID)
3. Go back to **SQL Editor**
4. Run this (replace with your actual User ID):
```sql
INSERT INTO user_roles (user_id, role) 
VALUES ('your-user-id-here', 'manager');
```

### Step 6: Refresh Your App
1. Go back to http://localhost:3000
2. Refresh the page
3. You should now see the manager dashboard with options!

## Next Steps After Migration
1. **Add Shops**: Dashboard → Shops → Add all 11 shops
2. **Add Products**: Dashboard → Products → Add your items
3. **Assign Items to Shops**: Dashboard → Products → "Assign Items to Shops"
4. **Create a Session**: Dashboard → Stock Count Sessions → Create New Session

---

## About Localhost vs GitHub

### Why Localhost?
- **Development**: You test and build on your computer first
- **Fast**: Changes appear instantly without deploying
- **Safe**: You can break things without affecting production
- **Standard**: This is how all web development works

### The Workflow:
1. **Develop locally** (localhost:3000) ← You are here
2. **Test everything works**
3. **Push to GitHub** (save your code)
4. **Deploy to Vercel** (make it live on the internet)

### When You're Ready to Deploy:
1. Push code to GitHub
2. Connect GitHub to Vercel
3. Add environment variables in Vercel
4. Deploy - your app goes live!

**Right now, focus on getting it working locally first!**

