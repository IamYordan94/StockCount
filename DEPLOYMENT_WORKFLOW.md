# Deployment Workflow Guide

## How Code and Database Changes Work Together

### Quick Answer
**Code changes** (Next.js app) → Push to GitHub → Vercel auto-deploys  
**Database changes** (Supabase SQL) → Run directly in Supabase → Live immediately  
**They work independently!**

---

## Detailed Explanation

### 1. **Code Changes (Next.js App)**

**When you need to push to GitHub/Vercel:**
- ✅ Adding new pages/components
- ✅ Changing UI/design
- ✅ Adding new API routes
- ✅ Fixing bugs in the code
- ✅ Updating dependencies (`package.json`)

**Process:**
1. Make changes in Cursor/your editor
2. Commit to GitHub: `git add -A && git commit -m "message" && git push`
3. Vercel automatically detects the push and redeploys
4. Your website updates in ~2-3 minutes

**Example:**
- You add a new "Reports" page → Push to GitHub → Vercel redeploys → Page is live

---

### 2. **Database Changes (Supabase)**

**When you only need to run SQL in Supabase:**
- ✅ Running migrations (creating tables, adding columns)
- ✅ Running seed data (inserting shops, items)
- ✅ Updating user roles
- ✅ Fixing data issues
- ✅ Adding RLS policies

**Process:**
1. Go to Supabase Dashboard → SQL Editor
2. Paste and run your SQL
3. Changes are **immediately live** - no deployment needed!

**Example:**
- You run the seed SQL → Shops appear immediately in your app
- You update a user's role → They see admin features immediately

---

### 3. **When You Need BOTH**

**Scenario 1: New Feature with Database Changes**
- Add new table in Supabase (migration)
- Add code to use that table (API routes, pages)
- **Do both:** Run SQL first, then push code

**Scenario 2: Schema Change**
- Add new column to existing table (migration)
- Update code to use that column
- **Do both:** Run SQL first, then push code

---

## Common Workflows

### Monthly Stock Count Setup
1. **Supabase only:** Create new stock count period (via UI or SQL)
2. **Supabase only:** Assign shops to users
3. **No code push needed!** Everything works immediately

### Adding New Features
1. **Supabase:** Run migration SQL (if needed)
2. **Code:** Add new pages/components
3. **GitHub:** Push code changes
4. **Vercel:** Auto-deploys

### Fixing Data Issues
1. **Supabase only:** Run SQL to fix data
2. **No code push needed!**

---

## Important Notes

### ✅ **Supabase Changes Are Instant**
- When you run SQL in Supabase, changes are **immediately** available
- Your app (on Vercel) connects to Supabase in real-time
- No need to redeploy Vercel for database changes

### ✅ **Code Changes Require Deployment**
- Code changes must be pushed to GitHub
- Vercel automatically redeploys (if connected)
- Takes 2-3 minutes to go live

### ✅ **Environment Variables**
- Supabase URL and keys are stored in Vercel
- If you change these, update Vercel environment variables
- Usually set once during initial setup

---

## Summary Table

| Change Type | Where to Make It | Needs GitHub Push? | Needs Vercel Redeploy? |
|------------|------------------|-------------------|------------------------|
| Add new page | Code (Cursor) | ✅ Yes | ✅ Auto (via Vercel) |
| Fix UI bug | Code (Cursor) | ✅ Yes | ✅ Auto (via Vercel) |
| Add new table | Supabase SQL | ❌ No | ❌ No |
| Insert seed data | Supabase SQL | ❌ No | ❌ No |
| Update user role | Supabase SQL | ❌ No | ❌ No |
| Add new API route | Code (Cursor) | ✅ Yes | ✅ Auto (via Vercel) |
| Change database schema | Supabase SQL | ❌ No | ❌ No |

---

## Best Practice

1. **For database changes:** Just run SQL in Supabase - it's instant!
2. **For code changes:** Push to GitHub - Vercel handles the rest
3. **For both:** Run SQL first, then push code

**You don't need to manually redeploy Vercel** - it's connected to GitHub and auto-deploys on every push!

