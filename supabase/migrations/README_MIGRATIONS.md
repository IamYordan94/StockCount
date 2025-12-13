# Database Migrations Guide

## Migration Files

### 001_initial_schema.sql
Creates all database tables, indexes, security policies, and default categories.
**Run this first!**

### 002_insert_shops.sql
Inserts all 11 shop names into the database.
- Winkel Rijks
- Ponton Rijks
- ARK Rijks
- Leidse
- CS Oost
- Bridge
- Damrak 5
- Damrak 6
- Vlaggenwinkel
- Damrak 4
- VC

**Run this after 001_initial_schema.sql**

### 003_insert_items_first_four_shops.sql
Inserts all items from the first 4 shops (Winkel Rijks, Ponton Rijks, ARK Rijks, Leidse) and creates shop-item assignments.

**Run this after 002_insert_shops.sql**

### 004_insert_items_cs_oost.sql
Inserts all items from CS Oost shop and creates shop-item assignments.
- DRANK CATERING items (wines, beers, soft drinks, PRIDE EVENT beverages)
- ETEN CATERING items (cheese, snacks, tea, spices)

**Run this after 003_insert_items_first_four_shops.sql**

### 005_insert_items_bridge.sql
Inserts shop-item assignments for Bridge shop.
- DRANK SHOP items (beverages)
- ETEN items (food/snacks)
- IJSJES items (ice cream)
- STROMMA BRANDED items (branded snacks)
- KAAS items (cheese)

**Run this after 004_insert_items_cs_oost.sql**

### 006_insert_items_damrak5.sql
Inserts shop-item assignments for Damrak 5 shop.
- IJSJES items (ice cream)
- DRANK SHOP items (beverages)
- ETEN items (food/snacks)
- STROMMA BRANDED items (branded snacks)
- KAAS items (cheese)

**Run this after 005_insert_items_bridge.sql**

### 007_insert_items_damrak6.sql
Inserts shop-item assignments for Damrak 6 shop.
- IJSJES items (ice cream)
- DRANK SHOP items (beverages)
- ETEN items (food/snacks)
- STROMMA BRANDED items (branded snacks)
- KAAS items (cheese)

**Run this after 006_insert_items_damrak5.sql**

### 008_insert_items_damrak4.sql
Inserts items and shop-item assignments for Damrak 4 shop.
- DRANK SHOP items (beverages, including new items: Gluhwein, Chocomel)
- ETEN items (food/snacks)
- STROMMA BRANDED items (branded snacks)
- KAAS items (cheese)

**Run this after 007_insert_items_damrak6.sql**

### 009_insert_items_vlaggenwinkel.sql
Inserts items and shop-item assignments for Vlaggenwinkel shop.
- DRANK SHOP items (beverages, including new item: Brand IPA 33CL)
- ETEN items (food/snacks)
- IJSJES items (ice cream)
- STROMMA BRANDED items (branded snacks)
- KAAS items (cheese)

**Run this after 008_insert_items_damrak4.sql**

### 010_insert_items_vc.sql
Inserts shop-item assignments for VC shop.
- DRANK SHOP items (beverages - currently includes Sourcy Mineraalwater)
- Additional items can be added by uncommenting sections in the migration file

**Run this after 009_insert_items_vlaggenwinkel.sql**

**Note:** This migration currently includes only the item shown in the provided image. If VC shop has additional items, uncomment and modify the relevant sections in the migration file.

### 011_fix_user_roles_rls.sql
**IMPORTANT:** Fixes infinite recursion error in user_roles RLS policies.
- Removes the recursive manager policy that was causing "infinite recursion" errors
- Keeps the simple "users can view their own role" policy (no recursion)
- Manager operations are handled via API routes using service role

**Run this immediately if you see "infinite recursion" errors when checking roles!**

### 012_fix_all_rls_policies.sql
**CRITICAL:** Fixes RLS policies for all tables to allow manager operations.
- Creates a helper function `is_manager()` that bypasses RLS to check manager status
- Updates all RLS policies for shops, items, categories, shop_items, stock_count_sessions, stock_counts, user_roles, and user_shop_assignments
- This fixes the issue where managers couldn't create/edit/delete items, shops, sessions, etc.

**Run this after 011_fix_user_roles_rls.sql to enable all manager functionality!**

## How to Run Migrations

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Click **New query**
4. Copy and paste the contents of the migration file
5. Click **Run** (or press Ctrl+Enter)

## Migration Order

1. ✅ `001_initial_schema.sql` - Creates tables and structure
2. ✅ `002_insert_shops.sql` - Adds all 11 shops
3. ✅ `003_insert_items_first_four_shops.sql` - Adds items for first 4 shops
4. ✅ `004_insert_items_cs_oost.sql` - Adds items for CS Oost shop
5. ✅ `005_insert_items_bridge.sql` - Adds items for Bridge shop
6. ✅ `006_insert_items_damrak5.sql` - Adds items for Damrak 5 shop
7. ✅ `007_insert_items_damrak6.sql` - Adds items for Damrak 6 shop
8. ✅ `008_insert_items_damrak4.sql` - Adds items for Damrak 4 shop
9. ✅ `009_insert_items_vlaggenwinkel.sql` - Adds items for Vlaggenwinkel shop
10. ✅ `010_insert_items_vc.sql` - Adds items for VC shop
11. ⚠️ `011_fix_user_roles_rls.sql` - **FIXES INFINITE RECURSION ERROR** - Run this if you see role errors!
12. ⚠️ `012_fix_all_rls_policies.sql` - **FIXES ALL MANAGER OPERATIONS** - Run this to enable create/edit/delete for managers!

## Notes

- Migrations use `ON CONFLICT DO NOTHING` to prevent errors if data already exists
- Items are deduplicated automatically (same name + category = one item)
- Shop-item assignments link items to their respective shops
- All items and shops are editable through the app UI after migration

## All Migrations Complete!

All 11 shops now have migration files. If you need to add more items to any shop in the future, you can either:
- Edit the existing migration file and re-run it (using ON CONFLICT DO NOTHING prevents duplicates)
- Create a new migration file following the same pattern

