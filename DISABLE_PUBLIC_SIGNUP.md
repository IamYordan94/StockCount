# 🔒 How to Disable Public Signups (Closed Loop System)

To make your app a closed loop where only accounts you create can log in, you need to disable public signups in Supabase.

## Steps to Disable Public Signups

### 1. Go to Supabase Dashboard
1. Open your Supabase project dashboard
2. Navigate to **Authentication** → **Settings** (or **Configuration**)

### 2. Disable Email Signups
1. Find the **"Enable email signups"** toggle
2. **Turn it OFF** (disable it)
3. This prevents new users from signing up via the login page

### 3. Disable Other Providers (Optional but Recommended)
- Disable any OAuth providers (Google, GitHub, etc.) if enabled
- Keep only email/password authentication enabled, but with signups disabled

### 4. Save Changes
- Click **Save** or the changes should auto-save

## What This Means

✅ **What Still Works:**
- Users you create via the **Users** page in your app can still log in
- Existing users can still log in
- You (as manager) can still create new users

❌ **What's Disabled:**
- New users **cannot** sign up via the login page
- Public registration is completely blocked
- Only admin-created accounts can access the system

## Alternative: Use Email Allowlist (Advanced)

If you want even more control, you can:
1. Keep signups enabled
2. Use Supabase's email allowlist feature
3. Only allow specific email domains or addresses

But for a true closed loop, disabling signups is the simplest approach.

## Testing

After disabling signups:
1. Try to sign up with a new email on the login page
2. You should see an error or the signup option should be hidden
3. Only users you create via Dashboard → Users can log in

---

**Note:** The Supabase Auth UI component will automatically hide the signup option when signups are disabled in your Supabase settings.

