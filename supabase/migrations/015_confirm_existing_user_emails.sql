-- Confirm email for all existing users so they can log in
-- This is safe to run multiple times as it only updates unconfirmed users

UPDATE auth.users
SET email_confirmed_at = COALESCE(email_confirmed_at, NOW())
WHERE email_confirmed_at IS NULL;

-- Optional: You can also verify specific users by email
-- UPDATE auth.users
-- SET email_confirmed_at = NOW()
-- WHERE email = 'employee@example.com' AND email_confirmed_at IS NULL;

