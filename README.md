# Stock Count Application

A comprehensive stock counting application built with Next.js 14, Supabase, and TypeScript. Manage inventory across multiple shops with Excel import, role-based access control, and comprehensive reporting.

## Features

- **Multi-Shop Support**: Manage stock across multiple shops
- **Excel Import**: Import stock data from Excel files with multi-sheet support
- **Dual Quantity Tracking**: Track both packaging units ("Aantal") and loose pieces ("Losse stuks")
- **Role-Based Access**: Admin, Manager, and Staff roles with appropriate permissions
- **Stock History**: Complete audit trail of all stock changes
- **Reports & Analytics**: View stock levels and generate reports per shop
- **Responsive Design**: Mobile-friendly interface for on-site counting

## Tech Stack

- **Frontend**: Next.js 14 (App Router) with TypeScript
- **Backend**: Supabase (Database, Auth, Storage)
- **Deployment**: Vercel
- **Styling**: Tailwind CSS

## Getting Started

### Prerequisites

- Node.js 18+ installed
- A Supabase account and project

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd stock-count-app
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
Create a `.env.local` file in the root directory:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

4. Set up Supabase database:
   - Go to your Supabase project SQL Editor
   - Run the SQL migration from `supabase/migrations/001_initial_schema.sql`

5. Run the development server:
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

## Database Schema

The application uses the following main tables:

- **shops**: Store shop information
- **items**: Master item catalog
- **shop_stock**: Stock levels per shop (with packaging_units and loose_pieces)
- **stock_history**: Audit trail for all stock changes
- **user_roles**: Role assignments for users

## Excel Import Format

The application expects Excel files with the following structure:

- **Multiple sheets**: Each sheet represents one shop (sheet name = shop name)
- **Columns**:
  - Column A: `Productinformatie` (Item name)
  - Column B: `Verpakkings eenheid` (Packaging unit description)
  - Column C: `Aantal` (Packaging units - integer)
  - Column D: `Losse stuks` (Loose pieces - integer)
- **Categories**: Bolded header rows (e.g., "IJSJES", "DRANK", "ETEN") are used to categorize items

## User Roles

- **Admin**: Full access to all shops, can manage users and import data
- **Manager**: Access to assigned shop only, can view and update stock
- **Staff**: Access to assigned shop only, can count/update stock

## Deployment

### Deploy to Vercel

1. Push your code to GitHub
2. Import your repository in Vercel
3. Add environment variables in Vercel dashboard
4. Deploy

### Supabase Production Setup

1. Create a production Supabase project
2. Run the migration SQL in production
3. Update environment variables with production Supabase credentials
4. Configure authentication settings in Supabase dashboard

## License

MIT

