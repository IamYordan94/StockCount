# Stock Count Application

A mobile-friendly web application for managing monthly stock counts across multiple shop locations.

## Features

- Multi-location stock counting (11 shops)
- User authentication with role-based access (Manager/Owner and Employees)
- Mobile-responsive design for phone use
- Category-based item organization (food, drinks, cheese, etc.)
- Excel export functionality matching Wordbook format
- Session-based stock counting workflow

## Tech Stack

- **Framework**: Next.js 14 with TypeScript
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth
- **Styling**: Tailwind CSS
- **Deployment**: Vercel
- **Excel Export**: xlsx library

## Setup

1. Install dependencies:
```bash
npm install
```

2. Set up Supabase:
   - Create a new Supabase project at https://supabase.com
   - Go to SQL Editor and run the migration file: `supabase/migrations/001_initial_schema.sql`
   - This will create all necessary tables, policies, and default categories

3. Set up environment variables:
   Create a `.env.local` file with:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
   ```
   
   You can find these in your Supabase project settings:
   - Project URL → Settings → API → Project URL
   - Anon key → Settings → API → anon/public key
   - Service role key → Settings → API → service_role key (keep this secret!)

4. Create your first manager user:
   - Sign up through the app at `/login`
   - Go to Supabase Dashboard → Authentication → Users
   - Find your user and note the User ID
   - Go to SQL Editor and run:
   ```sql
   INSERT INTO user_roles (user_id, role) 
   VALUES ('your-user-id-here', 'manager');
   ```

5. Run the development server:
```bash
npm run dev
```

## Database Schema

See `supabase/migrations/` for SQL migration files.

## Deployment

1. Push to GitHub
2. Connect to Vercel
3. Add environment variables in Vercel dashboard
4. Deploy

