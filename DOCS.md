# Stock Intake Platform - Technical Documentation

## Table of Contents
1. [Overview](#overview)
2. [Setup Instructions](#setup-instructions)
3. [Environment Variables](#environment-variables)
4. [Database Schema](#database-schema)
5. [Role-Based Access Control](#role-based-access-control)
6. [API Endpoints](#api-endpoints)
7. [Offline Capabilities](#offline-capabilities)
8. [Variance Detection Engine](#variance-detection-engine)
9. [Acceptance Testing](#acceptance-testing)
10. [Deployment](#deployment)

---

## Overview

Stock Intake Platform is a phone-friendly multi-location inventory management system designed for businesses with multiple shops (1-10) and a fixed catalog of items (1-40). The platform features:

- **Role-Based Access Control**: Three user types (OWNER, SUPERVISOR, EMPLOYEE)
- **Offline Support**: IndexedDB autosave and sync queue
- **Variance Detection**: Automated stock variance calculation and severity flagging
- **Approval Workflows**: Multi-level approval with self-approval prevention
- **Period Locking**: Prevent edits to finalized inventory periods
- **Cost Management**: Track item costs with effective date tracking
- **Movement Tracking**: Integration with POS systems for purchases/sales/transfers/wastage
- **Excel Export**: Consolidated reporting with 4 worksheets

---

## Setup Instructions

### Prerequisites
- Node.js 18+ installed
- PostgreSQL database (Neon recommended)
- Replit account (optional, for deployment)

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd stock-intake-platform
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**
   ```bash
   cp env.example .env
   ```
   - `DATABASE_URL`: Supabase/Neon/Postgres URI (e.g. from Supabase → Project Settings → Connection string)
   - `SESSION_SECRET`: 32+ character random string (`openssl rand -base64 32`)
   - `PORT` (optional): defaults to `5000`
   - `SEED_ON_START`: set to `true` only when you intentionally want to re-run `seedDatabase()`

4. **Initialize the database**
   ```bash
   npm run db:push   # apply schema
   npm run seed      # load shops/items/users from server/seed-data.json
   ```

5. **Start the development server**
   ```bash
   npm run dev
   ```

6. **Access the application**
   - Open your browser to `http://localhost:5000`
   - Default login credentials:
     - **Username**: `admin`
     - **Password**: `admin123`
     - **Role**: OWNER (full access)

### Production Deployment

#### Recommended: Supabase + Vercel

1. **Provision Supabase** (free tier covers ~500 MB)
   - Create a project and copy the `postgresql://` URI
   - Locally set `.env` → `npm run db:push && npm run seed`
2. **Link Vercel project**
   - `vercel link`
   - Add secrets once:
     ```bash
     vercel secret add stocksense_database_url "<postgresql://...>"
     vercel secret add stocksense_session_secret "<32-char-random>"
     ```
3. **Deploy**
   - `vercel --prod`
   - Vercel builds the Vite client to `dist/public` and exposes the Express API through `api/index.ts`

#### Self-hosted Node server

1. **Set environment variables** in your hosting platform
2. **Build the application**
   ```bash
   npm run build
   ```
3. **Start the production server**
   ```bash
   npm start
   ```

---

## Environment Variables

### Required Variables

| Variable | Description | Example | Required |
|----------|-------------|---------|----------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://user:pass@host:5432/db` | ✅ Yes |
| `SESSION_SECRET` | Secret key for session encryption | `generate-random-32-char-string` | ✅ Yes |

### Optional Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `PORT` | Server port number | `5000` | ❌ No |
| `NODE_ENV` | Environment mode | `development` | ❌ No |
| `SEED_ON_START` | Run the high-volume seed on boot (dev only) | `false` | ❌ No |

### Security Notes
- **Never commit secrets to version control**
- Generate `SESSION_SECRET` using: `openssl rand -base64 32`
- Use environment-specific secrets for production

---

## Database Schema

### Core Tables

#### users
- **Purpose**: User authentication and authorization
- **Key Fields**: `id`, `username`, `password`, `role`, `isApproved`, `lastLogin`
- **Roles**: `OWNER`, `SUPERVISOR`, `EMPLOYEE`

#### shops
- **Purpose**: Store locations (10 fixed shops)
- **Key Fields**: `id`, `code`, `name`, `isActive`
- **Note**: Shop 2 (Rijksmuseum) has custom UI with Dutch labels

#### items
- **Purpose**: Inventory catalog (40 fixed items)
- **Key Fields**: `id`, `defaultName`, `category`, `sku`, `uom`, `packSize`
- **Categories**: `FOOD`, `DRINK`, `ICECREAM`, `STROMMA`

#### costs
- **Purpose**: Track item costs with effective date tracking
- **Key Fields**: `id`, `itemId`, `costPerUom`, `currency`, `effectiveFrom`
- **Access**: OWNER only

#### counting_sessions
- **Purpose**: Inventory counting periods
- **Key Fields**: `id`, `shopId`, `status`, `periodStart`, `periodEnd`, `isLocked`
- **Statuses**: `draft`, `submitted`, `approved`, `rejected`

#### count_lines
- **Purpose**: Individual item counts
- **Key Fields**: `id`, `sessionId`, `itemId`, `boxes`, `singles`, `note`, `variance`
- **Computed**: Variance calculated by engine

#### movements
- **Purpose**: Stock movements from POS integration
- **Key Fields**: `id`, `shopId`, `itemId`, `type`, `quantity`, `movementDate`
- **Types**: `PURCHASE`, `SALE`, `TRANSFER_IN`, `TRANSFER_OUT`, `WASTAGE`

#### event_logs
- **Purpose**: Audit trail for all mutations
- **Key Fields**: `id`, `userId`, `action`, `entityType`, `beforeJson`, `afterJson`
- **Captured Actions**: CREATE, UPDATE, DELETE, APPROVE, REJECT, LOCK

---

## Role-Based Access Control

### Role Permissions Matrix

| Feature | EMPLOYEE | SUPERVISOR | OWNER |
|---------|----------|------------|-------|
| **Authentication** |
| Login | ✅ | ✅ | ✅ |
| Manage Users | ❌ | ❌ | ✅ |
| Approve Users | ❌ | ❌ | ✅ |
| **Inventory Counting** |
| View Assigned Shops | ✅ | ✅ | ✅ |
| Create Count Sessions | ✅ | ✅ | ✅ |
| Enter Count Data | ✅ | ✅ | ✅ |
| Submit for Approval | ✅ | ✅ | ✅ |
| **Approvals** |
| View Pending Approvals | ❌ | ✅ | ✅ |
| Approve/Reject Counts | ❌ | ✅ | ✅ |
| Request Recount | ❌ | ✅ | ✅ |
| Self-Approval Prevention | N/A | ✅ | ✅ |
| **Reporting** |
| View Variance Reports | ❌ | ✅ | ✅ |
| Export Consolidated XLSX | ❌ | ✅ | ✅ |
| **Cost Management** |
| View Item Costs | ❌ | ✅ | ✅ |
| Create/Update Costs | ❌ | ❌ | ✅ |
| Delete Costs | ❌ | ❌ | ✅ |
| **Period Locking** |
| View Lock Status | ❌ | ✅ | ✅ |
| Lock/Unlock Periods | ❌ | ❌ | ✅ |
| **System Configuration** |
| Manage Shops | ❌ | ❌ | ✅ |
| Manage Items | ❌ | ❌ | ✅ |
| Sync Movements (POS) | ❌ | ❌ | ✅ |
| View Audit Logs | ❌ | ❌ | ✅ |

### Authorization Enforcement

**Frontend**: Role checks at component level
```typescript
if (!user || user.role !== 'OWNER') {
  return <div>Access Denied</div>;
}
```

**Backend**: Middleware enforcement
```typescript
requireRole(['OWNER'])
```

---

## API Endpoints

### Authentication
- `POST /api/register` - Register new user (requires approval)
- `POST /api/login` - User login
- `POST /api/logout` - User logout
- `GET /api/user` - Get current user

### Users Management
- `GET /api/users` - List all users (admin only)
- `PUT /api/users/:id/approve` - Approve user registration (admin only)
- `PUT /api/users/:id/role` - Update user role (admin only)
- `DELETE /api/users/:id` - Delete user (admin only)

### Inventory Counting
- `GET /api/shops` - List all shops
- `GET /api/items` - List all items
- `GET /api/sessions` - List count sessions (filtered by permissions)
- `POST /api/sessions` - Create new count session
- `GET /api/sessions/:id` - Get session details
- `PUT /api/sessions/:id` - Update session
- `DELETE /api/sessions/:id` - Delete session
- `GET /api/counts/:sessionId` - Get count lines for session
- `POST /api/counts` - Save count line
- `DELETE /api/counts/:id` - Delete count line

### Approvals Workflow
- `GET /api/counts/list` - List counts for approval (supervisor+)
- `POST /api/counts/:id/approve` - Approve count session
- `POST /api/counts/:id/reject` - Reject count session
- `POST /api/counts/:id/recount` - Request recount

### Cost Management
- `GET /api/costs?itemId=X` - Get cost history for item (supervisor+)
- `POST /api/costs` - Create new cost entry (admin only)
- `PUT /api/costs/:id` - Update cost entry (admin only)
- `DELETE /api/costs/:id` - Delete cost entry (admin only)

### Movements Tracking
- `POST /api/movements/sync` - Sync movements from POS (admin only)

### Reporting & Exports
- `GET /api/reports/variance?start=X&end=Y&shopId=Z` - Variance report (supervisor+)
- `GET /api/exports/consolidated.xlsx?start=X&end=Y` - Excel export (supervisor+)

### Period Locking
- `POST /api/periods/lock` - Lock period (admin only)
- `GET /api/periods/locks?shopId=X` - Get lock status (supervisor+)

---

## Offline Capabilities

### IndexedDB Storage
- **Database Name**: `stock-intake-db`
- **Stores**: `counts`, `sync-queue`
- **Auto-save**: Every 500ms debounced

### Sync Queue
When offline, mutations are queued:
```typescript
{
  id: string,
  timestamp: number,
  operation: 'create' | 'update' | 'delete',
  endpoint: string,
  data: any
}
```

### Sync Process
1. User goes offline → writes to IndexedDB
2. User comes online → sync queue processes
3. Each operation retries with exponential backoff
4. Success → remove from queue
5. Failure → keep in queue for next sync

---

## Variance Detection Engine

### Calculation Formula
```
Expected = Opening Stock + Purchases - Sales - Transfers Out - Wastage
Variance = Physical Count - Expected
Variance % = (Variance / Expected) × 100
```

### Severity Levels

| Severity | Condition | Color | Action |
|----------|-----------|-------|--------|
| **INFO** | Variance ≤ 5% | 🟢 Green | Normal |
| **WARN** | 5% < Variance ≤ 15% | 🟡 Yellow | Review recommended |
| **CRITICAL** | Variance > 15% | 🔴 Red | Investigation required |

### Variance Threshold Configuration
Stored in `variance_thresholds` table:
- `category`: Item category (e.g., FOOD, DRINK)
- `warnThreshold`: Warning threshold (default: 5%)
- `criticalThreshold`: Critical threshold (default: 15%)

---

## Acceptance Testing

### Test Mapping

#### Test 1: Offline Count Sync
**Objective**: Verify offline counting and sync functionality

**Steps**:
1. Open app in incognito mode
2. Login as EMPLOYEE user
3. Navigate to counting page
4. Disconnect network (DevTools → Network → Offline)
5. Enter count data (boxes=5, singles=10)
6. Verify data saved to IndexedDB
7. Reconnect network
8. Verify sync queue processes
9. Verify count appears in backend

**Expected**: Count data persists offline and syncs when online

**Endpoints**: `POST /api/counts`, IndexedDB `sync-queue` store

---

#### Test 2: Variance Severity Enforcement
**Objective**: Verify variance calculation and severity flagging

**Steps**:
1. Login as SUPERVISOR
2. Create movement: PURCHASE 100 units
3. Create count session with 85 units (15% variance)
4. Submit for approval
5. Navigate to Approvals page
6. Verify variance shows as CRITICAL (red)
7. Verify variance % displays correctly

**Expected**: Variance calculated correctly with severity flag

**Endpoints**: `GET /api/counts/list`, `POST /api/counts/:id/approve`

**Validation**:
- `variance.severity === 'CRITICAL'`
- `variance.variancePercent === -15`
- UI shows red badge

---

#### Test 3: Self-Approval Blocking
**Objective**: Verify users cannot approve their own counts

**Steps**:
1. Login as SUPERVISOR (user ID = 3)
2. Create count session for Shop 1
3. Submit count
4. Navigate to Approvals page
5. Verify "Cannot approve own count" indicator displayed
6. Attempt to approve (should show disabled state)
7. Login as different SUPERVISOR
8. Verify approval button is enabled

**Expected**: Self-approval prevented with clear indicator

**Endpoints**: `POST /api/counts/:id/approve`

**Validation**:
- Backend returns 403 if userId === count.userId
- Frontend shows yellow warning badge
- Approve button disabled for own counts

---

#### Test 4: Period Lock 409 Responses
**Objective**: Verify locked periods prevent edits

**Steps**:
1. Login as OWNER
2. Create count session (2025-01-01 to 2025-01-31)
3. Submit and approve count
4. Navigate to Reports → Period Lock
5. Lock period (2025-01-01 to 2025-01-31, Shop 1)
6. Attempt to edit count in locked period
7. Verify 409 response received
8. Verify toast shows "Period is locked"

**Expected**: Edits to locked periods rejected with 409

**Endpoints**: 
- `POST /api/periods/lock`
- `PUT /api/counts/:id` (should return 409)

**Validation**:
- Response status === 409
- Error message: "Cannot modify counts in locked period"

---

#### Test 5: XLSX Export Validation
**Objective**: Verify consolidated Excel export structure

**Steps**:
1. Login as SUPERVISOR
2. Create multiple count sessions across different shops
3. Add variance data (some with wastage)
4. Navigate to Reports page
5. Click "Export Consolidated Report"
6. Download XLSX file
7. Open in Excel/LibreOffice
8. Verify 4 worksheets exist:
   - InventorySnapshot
   - Variances
   - Wastage
   - AuditTrail

**Expected**: XLSX contains correct structure and data

**Endpoints**: `GET /api/exports/consolidated.xlsx`

**Validation**:
- InventorySnapshot: shopName, itemName, quantity, cost, value
- Variances: itemName, expected, actual, variance, severity
- Wastage: movementDate, itemName, quantity, estimatedCost
- AuditTrail: timestamp, username, action, entity

**Data Integrity**:
- Latest count per shop/item (deduplication)
- Variance calculations match UI
- No duplicate entries

---

#### Test 6: Role-Based Access Control
**Objective**: Verify role permissions enforced

**Steps**:
1. Test as EMPLOYEE:
   - Navigate to /cost-management → Expect "Access Denied"
   - Navigate to /approvals → Expect "Access Denied"
   - Navigate to /reports → Expect "Access Denied"
2. Test as SUPERVISOR:
   - Navigate to /approvals → Expect access granted
   - Navigate to /reports → Expect access granted
   - Navigate to /cost-management → Expect "Access Denied"
3. Test as OWNER:
   - All pages → Expect access granted
   - Create cost entry → Expect success

**Expected**: Access control enforced at frontend and backend

**Endpoints**: All endpoints with `requireRole` middleware

---

#### Test 7: Movement Tracking Integration
**Objective**: Verify POS movement sync updates stock

**Steps**:
1. Login as OWNER
2. POST to `/api/movements/sync`:
   ```json
   {
     "movements": [
       {
         "shopId": 1,
         "itemId": 1,
         "type": "PURCHASE",
         "quantity": 100,
         "movementDate": "2025-01-15"
       }
     ]
   }
   ```
3. Create count session for same shop/item
4. Verify expected stock includes purchase
5. Verify variance calculated correctly

**Expected**: Movements affect variance calculation

**Endpoints**: `POST /api/movements/sync`, `GET /api/counts/:id`

---

#### Test 8: Cost Effective Date Tracking
**Objective**: Verify historical cost tracking

**Steps**:
1. Login as OWNER
2. Create cost entry:
   - Item: Item 1
   - Cost: €5.00
   - Effective From: 2025-01-01
3. Create second cost entry:
   - Item: Item 1
   - Cost: €6.50
   - Effective From: 2025-02-01
4. View cost history for Item 1
5. Verify both entries displayed in date order
6. Verify variance report uses correct cost for each period

**Expected**: Cost changes tracked with effective dates

**Endpoints**: `POST /api/costs`, `GET /api/costs?itemId=1`

---

## Deployment

### Database Migration
```bash
npm run db:push
```

### Automatic Seeding
On first startup with empty database:
- 4 users created (1 OWNER: admin; 3 EMPLOYEE: Zuid, catering, central)
- 10 shops activated
- 383 items loaded
- 382 shop-item configurations
- User-shop permissions assigned

### Production Checklist
- [ ] Set `NODE_ENV=production`
- [ ] Generate secure `SESSION_SECRET`
- [ ] Configure `DATABASE_URL` for production database
- [ ] Run database migrations
- [ ] Verify seed data loaded
- [ ] Test login with default admin credentials
- [ ] Change default admin password
- [ ] Configure HTTPS/SSL
- [ ] Set up backup schedule for PostgreSQL
- [ ] Monitor audit logs for security

---

## Troubleshooting

### Database Connection Issues
**Error**: `DATABASE_URL must be set`
**Solution**: Ensure `.env` file contains valid PostgreSQL connection string

### Session Errors
**Error**: `Session secret not configured`
**Solution**: Set `SESSION_SECRET` environment variable

### Migration Failures
**Error**: Primary key type mismatch
**Solution**: Run `npm run db:push --force` to force sync schema

### Offline Sync Issues
**Error**: Sync queue not processing
**Solution**: 
1. Open DevTools → Application → IndexedDB
2. Check `sync-queue` store for pending operations
3. Verify network connection
4. Check browser console for errors

---

## Support

For technical issues or questions:
1. Check this documentation
2. Review audit logs in `/api/event-logs`
3. Check browser console for frontend errors
4. Check server logs for backend errors

---

## License

Proprietary - All rights reserved
