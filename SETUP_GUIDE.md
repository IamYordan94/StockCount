# Stock Count App - Setup Guide

## Overview

This is a complete stock counting web application built for managing monthly stock counts across 11 shop locations. The app is mobile-friendly and allows employees to count stock on their phones, while managers can oversee the process and export results to Excel.

## Features

✅ **Multi-location support** - Manage 11 shops
✅ **Role-based access** - Manager and Employee roles
✅ **Mobile-responsive** - Works perfectly on phones
✅ **Session-based counting** - Start monthly counting sessions
✅ **Category organization** - Items organized by Food, Drinks, Cheese, Other
✅ **Excel export** - Download results matching your Wordbook format
✅ **User management** - Add/edit users and assign them to shops
✅ **Product management** - Add/edit items and assign them to shops

## Quick Start

### 1. Install Dependencies

```bash
npm install
```

### 2. Set Up Supabase

1. Go to https://supabase.com and create a new project
2. Wait for the project to be ready (takes a few minutes)
3. Go to **SQL Editor** in your Supabase dashboard
4. Copy the entire contents of `supabase/migrations/001_initial_schema.sql`
5. Paste and run it in the SQL Editor
6. This creates all tables, policies, and default categories

### 3. Get Your Supabase Keys

1. In Supabase dashboard, go to **Settings** → **API**
2. Copy these values:
   - **Project URL** (for `NEXT_PUBLIC_SUPABASE_URL`)
   - **anon public** key (for `NEXT_PUBLIC_SUPABASE_ANON_KEY`)
   - **service_role** key (for `SUPABASE_SERVICE_ROLE_KEY`) - Keep this secret!

### 4. Create Environment File

Create a `.env.local` file in the root directory:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here
```

### 5. Create Your First Manager Account

1. Run the app: `npm run dev`
2. Go to http://localhost:3000
3. Sign up with your email and password
4. Go to Supabase dashboard → **Authentication** → **Users**
5. Find your user and copy the **User ID** (UUID)
6. Go to **SQL Editor** and run:

```sql
INSERT INTO user_roles (user_id, role) 
VALUES ('paste-your-user-id-here', 'manager');
```

7. Refresh the app - you should now see the manager dashboard!

### 6. Initial Setup (As Manager)

1. **Add Shops**: Go to Dashboard → Shops → Add all 11 shops
2. **Add Categories**: Default categories (Food, Drinks, Cheese, Other) are already created
3. **Add Products**: Go to Dashboard → Products → Add all your items
4. **Assign Items to Shops**: Go to Dashboard → Products → "Assign Items to Shops"
   - Select a shop
   - Check the items that should appear in that shop's counting interface
5. **Add Users**: Go to Dashboard → Users → Add employees
   - Assign them to specific shops
   - They'll only see shops they're assigned to

## How to Use

### For Managers

1. **Start a Stock Count Session**:
   - Go to Dashboard → Stock Count Sessions
   - Click "Create New Session"
   - Name it (e.g., "January 2024")
   - Employees can now count for this session

2. **Download Results**:
   - Go to Stock Count Sessions
   - Click "Download Excel" on any session
   - The Excel file will have one tab per shop, matching your Wordbook format

3. **Manage Everything**:
   - **Products**: Add/edit items and their pack sizes
   - **Users**: Add employees, assign them to shops, change roles
   - **Shops**: Add/edit shop locations

### For Employees

1. **Count Stock**:
   - Go to Dashboard → Count Stock
   - Select the active session
   - Select your assigned shop
   - Items are grouped by category
   - Enter boxes and singles for each item
   - Click "Save Counts" when done

2. **Multiple Shops**:
   - If assigned to multiple shops, select each one and count separately
   - Each shop's counts are saved independently

## Excel Export Format

The exported Excel file matches your Wordbook format:
- One tab per shop (named after the shop)
- Items grouped by category
- Columns: Item Name, Pack Size, Boxes, Singles
- Empty rows between categories

## Deployment to Vercel

1. Push your code to GitHub
2. Go to https://vercel.com
3. Import your GitHub repository
4. Add environment variables in Vercel:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`
5. Deploy!

## Important Notes

- **Service Role Key**: This is required for user management. Keep it secret and only use it server-side (it's already configured in the API routes).
- **First Manager**: You must manually set your role to 'manager' in the database (see step 5 above).
- **Shop Items**: By default, if no items are assigned to a shop, all items will show. Use "Assign Items to Shops" to customize per shop.
- **Sessions**: Only active sessions appear in the employee counting interface.

## Troubleshooting

**Can't see manager options?**
- Make sure you set your role to 'manager' in the database
- Check that you're logged in with the correct account

**Users can't see shops?**
- Make sure shops are assigned to users in Dashboard → Users
- Employees only see shops they're assigned to

**Excel export is empty?**
- Make sure counts have been saved for that session
- Check that items are assigned to shops

**Can't create users?**
- Make sure `SUPABASE_SERVICE_ROLE_KEY` is set in your environment variables
- Check Vercel environment variables if deployed

## Support

If you encounter any issues:
1. Check the browser console for errors
2. Check Supabase logs in the dashboard
3. Verify all environment variables are set correctly
4. Make sure the database migration ran successfully

