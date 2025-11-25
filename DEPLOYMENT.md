# Deployment Guide for StockSense

## Quick Answer: Will GitHub → Vercel Work?

**Yes, but you need to fix TypeScript errors first.** The app is set up for Vercel deployment, but there are some code issues that need fixing before it will build successfully.

---

## Step-by-Step Deployment Process

### 1. Fix TypeScript Errors (Required First)

Before deploying, you need to fix these errors. The code references database columns that don't exist in the schema:

**Errors to fix:**
- `server/routes.ts` line 703: `counts.status` type mismatch
- `server/routes.ts` line 754: `rejectedReason` should be `rejectionReason`
- `server/routes.ts` lines 1684-1705: `movements` table missing columns (`movementType`, `movementDate`, `cost`, `reference`, `notes`)
- `server/variance-engine.ts`: References `counts.countedAt` which doesn't exist

**What this means:** The code is trying to use database columns that aren't defined. You need to either:
- Add these columns to the database schema (`shared/schema.ts`), OR
- Update the code to use the correct column names

---

### 2. Push to GitHub

1. Create a new repository on GitHub
2. Upload all your files (or use `git push`)
3. Make sure these files are included:
   - `api/index.ts` (Vercel serverless handler)
   - `vercel.json` (Vercel configuration)
   - `env.example` (template for environment variables)
   - All other project files

---

### 3. Set Up Supabase Database (Free Tier)

1. Go to [supabase.com](https://supabase.com) and sign up
2. Create a new project
3. Wait for the database to be created (takes ~2 minutes)
4. Go to **Settings → Database**
5. Copy the **Connection String** (looks like: `postgresql://postgres:[YOUR-PASSWORD]@db.xxxxx.supabase.co:5432/postgres`)

---

### 4. Set Up Vercel Environment Variables

In Vercel, you have two options:

#### Option A: Import from `.env` file (Easier)

1. Create a file called `.env` in your project root with this content:

```env
DATABASE_URL=postgresql://postgres:YOUR_PASSWORD@db.xxxxx.supabase.co:5432/postgres
SESSION_SECRET=your-random-32-character-secret-key-here
SEED_ON_START=false
```

**Important:**
- Replace `YOUR_PASSWORD` with your actual Supabase database password
- Replace `xxxxx` with your Supabase project ID
- Generate a random `SESSION_SECRET` (you can use: `openssl rand -base64 32` or any random 32+ character string)

2. In Vercel dashboard → Your Project → Settings → Environment Variables
3. Click "Import" and select your `.env` file

#### Option B: Add Manually (More Secure)

In Vercel dashboard → Your Project → Settings → Environment Variables, add these three variables:

| Variable Name | Value | Environment |
|--------------|-------|-------------|
| `DATABASE_URL` | `postgresql://postgres:YOUR_PASSWORD@db.xxxxx.supabase.co:5432/postgres` | Production, Preview, Development |
| `SESSION_SECRET` | `your-random-32-character-secret-key` | Production, Preview, Development |
| `SEED_ON_START` | `false` | Production, Preview, Development |

**Note:** Replace the placeholders with your actual values from Supabase.

---

### 5. Deploy to Vercel

1. Go to [vercel.com](https://vercel.com) and sign in
2. Click "Add New Project"
3. Import your GitHub repository
4. Vercel will automatically detect the settings from `vercel.json`
5. Click "Deploy"

**What happens:**
- Vercel runs `npm install`
- Vercel runs `npm run build` (this will fail if TypeScript errors aren't fixed)
- If successful, your app goes live!

---

### 6. Initialize Database (First Time Only)

After your first successful deployment:

1. **Option 1: Run locally** (Recommended)
   - Clone your repo locally
   - Create a `.env` file with your Supabase `DATABASE_URL`
   - Run: `npm run db:push` (creates tables)
   - Run: `npm run seed` (adds shops, items, users)

2. **Option 2: Use Supabase SQL Editor**
   - Go to Supabase dashboard → SQL Editor
   - Run the migration SQL from `migrations/` folder
   - Then run the seed script manually

---

## Environment Variables Explained

### Required Variables

| Variable | What It Does | Where to Get It |
|----------|-------------|-----------------|
| `DATABASE_URL` | Connection to your PostgreSQL database | Supabase Settings → Database → Connection String |
| `SESSION_SECRET` | Encrypts user login sessions | Generate randomly (32+ characters) |

### Optional Variables

| Variable | Default | What It Does |
|----------|---------|-------------|
| `SEED_ON_START` | `false` | If `true`, automatically adds test data on every startup (only use for development) |
| `PORT` | `5000` | Server port (Vercel ignores this, uses its own) |
| `NODE_ENV` | `development` | Set to `production` automatically by Vercel |

---

## Remaining TODO Items (Not Blocking Deployment)

These are feature improvements, not required for basic deployment:

1. **Auth & Role Guards** - Polish the login flow and permission checks
2. **Counting UX** - Improve the mobile counting interface (plus/minus buttons, numeric keyboard)
3. **Approvals & Export** - Test and polish the supervisor approval workflow and Excel export

**You can deploy now and fix these later!**

---

## Troubleshooting

### Build Fails with TypeScript Errors
- Fix the errors listed in Step 1 above
- Or temporarily add `// @ts-ignore` comments (not recommended for production)

### Database Connection Fails
- Check your `DATABASE_URL` is correct
- Make sure your Supabase project is active
- Check Supabase firewall settings (should allow all IPs by default)

### App Deploys But Shows Errors
- Check Vercel function logs (Dashboard → Your Project → Functions)
- Make sure environment variables are set correctly
- Verify database tables exist (run `npm run db:push` locally)

---

## Quick Checklist

Before deploying:
- [ ] Fix TypeScript errors (or the build will fail)
- [ ] Create Supabase project and get `DATABASE_URL`
- [ ] Generate a `SESSION_SECRET` (32+ characters)
- [ ] Push code to GitHub
- [ ] Set environment variables in Vercel
- [ ] Deploy!

After deploying:
- [ ] Run database migrations (`npm run db:push`)
- [ ] Seed initial data (`npm run seed`)
- [ ] Test login with default admin account
- [ ] Change default admin password!

---

## Need Help?

If you get stuck:
1. Check Vercel deployment logs
2. Check Supabase database logs
3. Verify all environment variables are set correctly
4. Make sure TypeScript errors are fixed before deploying

