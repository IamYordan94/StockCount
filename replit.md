# Overview

Stock Intake Platform is a phone-friendly multi-location inventory management system designed for businesses with multiple shops (1-10) and a fixed catalog of items (1-40). The platform supports role-based access control with three user types: OWNER, SUPERVISOR, and EMPLOYEE. The system features offline autosave capabilities, real-time inventory counting sessions, and Excel export functionality for data analysis.

# User Preferences

Preferred communication style: Simple, everyday language.

# System Architecture

## Frontend Architecture
- **Framework**: React with TypeScript using Vite as the build tool
- **UI Library**: Shadcn/UI components built on Radix UI primitives
- **Styling**: Tailwind CSS with CSS variables for theming
- **State Management**: TanStack Query for server state management
- **Routing**: Wouter for lightweight client-side routing
- **Offline Support**: IndexedDB via `idb` library for offline data storage and sync queue
- **PWA Features**: Service worker for caching and manifest.json for app installation

## Backend Architecture
- **Runtime**: Node.js with Express server
- **Database ORM**: Drizzle ORM with PostgreSQL
- **Authentication**: Passport.js with local strategy and session-based auth
- **Session Storage**: PostgreSQL session store using connect-pg-simple
- **Password Security**: Node.js crypto module with scrypt hashing
- **File Processing**: XLSX library for Excel export functionality

## Database Design
- **Users Table**: Stores user credentials, roles, approval status, and login tracking
- **Shops Table**: Fixed 10 shops with activation status
- **Items Table**: Fixed 40 items with categories (FOOD, DRINK, ICECREAM, STROMMA)
- **User-Shop Permissions**: Many-to-many relationship for shop access control
- **Counting Sessions**: Track inventory counting periods with open/closed status and automatic closure after 3 days
- **Count Lines**: Individual item counts with boxes and singles quantities
- **Event Logs**: Audit trail for user actions and system events

## Session Auto-Close Feature
- **Automatic Closure**: Sessions automatically close 3 days after creation to prevent blocking new counts
- **Auto-Close Date**: Set at session creation (createdAt + 3 days)
- **Trigger Mechanism**: Auto-close runs when sessions are accessed via API (getAllSessions or getActiveSession)
- **Admin Control**: Owners can manually close sessions at any time via the admin dashboard
- **UI Display**: Admin dashboard shows auto-close date for open sessions and closed date for closed sessions

## Role-Based Access Control
- **OWNER**: Full admin access, user management, shop configuration, cost management
- **SUPERVISOR**: Shop management, reporting capabilities, and approval workflows
- **EMPLOYEE**: Basic inventory counting access to assigned shops only

## Offline Capabilities
- **Auto-save**: Continuous saving of count data to IndexedDB
- **Sync Queue**: Queued operations for when connection is restored
- **Progressive Web App**: Installable with offline-first architecture
- **Service Worker**: Caches static assets and API responses

## Mobile-First Design
- **Responsive Layout**: Optimized for phone usage with touch-friendly interfaces
- **Touch Targets**: All interactive elements meet 48px minimum touch target size (WCAG AAA standard)
- **Adaptive Layouts**: Counter controls stack vertically on mobile, horizontal on desktop
- **Collapsible Categories**: Organized item grouping for easy navigation
- **Progress Tracking**: Visual indicators for counting session completion
- **Quick Input**: Streamlined quantity entry with +/- buttons
- **Footer Safety**: Bottom padding (pb-48 mobile, pb-40 desktop) prevents fixed footer from blocking content
- **No Horizontal Overflow**: All content fits within viewport on smallest supported devices (390px)

# External Dependencies

## Database
- **Neon Database**: Serverless PostgreSQL hosting
- **Connection**: WebSocket-based connection pooling for serverless environments

## Authentication
- **Session Management**: Express sessions with PostgreSQL storage
- **Password Hashing**: Node.js built-in crypto module with scrypt

## UI Components
- **Radix UI**: Accessible component primitives
- **Lucide React**: Icon library for consistent iconography
- **React Hook Form**: Form handling with Zod validation
- **Date-fns**: Date manipulation utilities

## Development Tools
- **TypeScript**: Type safety across frontend and backend
- **Vite**: Fast development server and build tool
- **Tailwind CSS**: Utility-first styling
- **Drizzle Kit**: Database migrations and schema management

## Build and Deployment
- **ESBuild**: Server-side bundling for production
- **Replit Integration**: Platform-specific development tools and error handling
- **Cartographer**: Development debugging tools (Replit environment only)
- **Automatic Database Seeding**: On first startup with empty database, automatically populates all shops, items, configurations, and admin account

# Deployment and Data Migration

## Automatic Database Seeding

When the app is published (deployed), the production database starts empty. The app includes an automatic seeding system that runs on first startup:

- **Seed Data**: Contains 4 users, 10 shops, 383 items, 382 shop-item configurations, and user-shop permissions
- **Automatic Detection**: Checks if database is empty before seeding
- **Transactional Safety**: All data inserted in a single transaction - either all succeeds or all rolls back
- **Password Security**: Plaintext passwords are automatically hashed using scrypt
- **Default Admin**: Admin account (username: admin, password: admin123) created automatically

## Login Credentials (Production)

After publishing, you can log in immediately with:
- **Username**: Admin
- **Password**: admin123
- **Role**: SUPERVISOR (full admin dashboard access)

Additional users are also created automatically based on the development database configuration.

**Note**: Both OWNER and SUPERVISOR roles have full access to the admin dashboard and all administrative features.