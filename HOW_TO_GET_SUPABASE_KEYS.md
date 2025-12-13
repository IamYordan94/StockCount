# How to Get Your Supabase Keys

Follow these steps to get all the values you need for your `.env.local` file:

## Step 1: Go to Your Supabase Project

1. Visit https://supabase.com and log in
2. Select your project (or create a new one if you haven't yet)

## Step 2: Navigate to API Settings

1. Click on the **Settings** icon (gear icon) in the left sidebar
2. Click on **API** in the settings menu

## Step 3: Find Your Values

You'll see a page with several sections. Here's what you need:

### 1. Project URL (`NEXT_PUBLIC_SUPABASE_URL`)

- Look for the **Project URL** section
- It will look like: `https://xxxxxxxxxxxxx.supabase.co`
- Copy this entire URL (including `https://`)

**Example:**
```
NEXT_PUBLIC_SUPABASE_URL=https://abcdefghijklmnop.supabase.co
```

### 2. Anon/Public Key (`NEXT_PUBLIC_SUPABASE_ANON_KEY`)

- Look for the **Project API keys** section
- Find the key labeled **`anon` `public`**
- Click the eye icon to reveal it, or click "Reveal" button
- Copy the entire key (it's a long string)

**Example:**
```
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiY2RlZmdoaWprbG1ub3AiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTYzODk2NzI5MCwiZXhwIjoxOTU0NTQzMjkwfQ.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 3. Service Role Key (`SUPABASE_SERVICE_ROLE_KEY`)

- Still in the **Project API keys** section
- Find the key labeled **`service_role` `secret`**
- ⚠️ **WARNING**: This key has admin privileges - keep it secret!
- Click "Reveal" to show it
- Copy the entire key

**Example:**
```
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiY2RlZmdoaWprbG1ub3AiLCJyb2xlIjoic2VydmljZV9yb2xlIiwiaWF0IjoxNjM4OTY3MjkwLCJleHAiOjE5NTQ1NDMyOTB9.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## Step 4: Update Your `.env.local` File

1. Open the `.env.local` file in your project root
2. Replace the placeholder values with the actual values you copied
3. Save the file

## Visual Guide

The Supabase API settings page looks like this:

```
┌─────────────────────────────────────────┐
│ Settings > API                          │
├─────────────────────────────────────────┤
│                                         │
│ Project URL                             │
│ https://xxxxx.supabase.co               │ ← Copy this
│                                         │
│ Project API keys                        │
│                                         │
│ [anon] [public]                         │
│ eyJhbGc...                              │ ← Copy this
│ [Reveal] [Copy]                         │
│                                         │
│ [service_role] [secret]                 │
│ eyJhbGc...                              │ ← Copy this
│ [Reveal] [Copy]                         │
│                                         │
└─────────────────────────────────────────┘
```

## Important Notes

- ✅ The **anon key** is safe to use in client-side code (it's public)
- ⚠️ The **service_role key** is SECRET - only use it server-side
- ✅ Never commit `.env.local` to GitHub (it's already in `.gitignore`)
- ✅ The service_role key is already configured to only work in API routes (server-side)

## Troubleshooting

**Can't find the keys?**
- Make sure you're in the correct Supabase project
- Check that you're looking at Settings → API (not Authentication or Database)

**Keys not working?**
- Make sure you copied the entire key (they're very long)
- Check for extra spaces before/after the key
- Verify you're using the correct project URL

**Service role key missing?**
- All Supabase projects have a service_role key
- If you can't see it, click "Reveal" to show it
- Make sure you're looking at the right section (Project API keys)

