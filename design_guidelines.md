# Stock Intake/Inventory Counting App - Design Guidelines

## Design Approach
**Material Design 3** foundation with mobile-first principles, optimized for rapid data entry and touch interaction. Drawing inspiration from modern inventory management tools and mobile-first productivity apps like Todoist and Notion's mobile experience.

## Core Design Principles
1. **Touch-First**: All interactive elements minimum 48px height
2. **Scan-Optimized**: High contrast, clear hierarchy for quick visual scanning
3. **Data Entry Speed**: Minimize taps, maximize efficiency
4. **Thumb-Friendly**: Critical actions within easy reach zones
5. **Forgiving**: Easy correction of count errors

---

## Typography System

**Primary Font**: Inter (Google Fonts)
**Secondary Font**: Inter (single family for consistency)

Hierarchy:
- Location/Page Headers: text-2xl (24px), font-semibold
- Category Headers: text-lg (18px), font-medium
- Item Names: text-base (16px), font-normal
- Item Codes/SKUs: text-sm (14px), font-normal, reduced opacity
- Count Numbers: text-xl (20px), font-semibold (high visibility)
- Buttons/Actions: text-base (16px), font-medium

---

## Layout System

**Spacing Units**: Tailwind 3, 4, 6, 8, 12 for consistent rhythm

Mobile (Primary):
- Screen padding: px-4
- Section spacing: space-y-4
- Component internal padding: p-4
- Compact list items: py-3, px-4

Desktop (Secondary):
- Max-width container: max-w-4xl mx-auto
- Increased padding: px-6
- Two-column capability for wide screens (split categories/details)

**Safe Zones**:
- Top: Account for notches and status bars (pt-safe or min 16px)
- Bottom: Account for gesture bars and nav (pb-safe or min 24px)
- Sides: Minimum 16px padding on all screens

---

## Component Library

### 1. App Header (Fixed Position)
Sticky top bar with:
- Location name (left, truncate on overflow)
- Current session info (center): "Counting: [Category Name]" or "Overview"
- Action menu icon (right, 48x48px tap target)
- Progress indicator: Subtle bar showing completion (e.g., "12/45 categories")
- Height: 64px (mobile), 72px (desktop)
- Background: Solid with subtle shadow for depth

### 2. Location Selection Screen (Entry Point)
Card-based grid layout:
- Each location as a large card (min 120px height)
- Location name (text-lg, font-semibold)
- Last counted date/time (text-sm, muted)
- Count status badge: "Complete" / "In Progress" / "Not Started"
- Full-width on mobile, 2-column grid on tablet+
- Cards have subtle border, rounded corners (rounded-xl)

### 3. Category Accordion System
Collapsible sections for organization:

**Collapsed State** (48px min-height):
- Left: Chevron icon (24x24px, rotates on expand)
- Center: Category name (text-lg, font-medium)
- Right: Count summary badge "12 items" or checkmark if complete
- Full-width tap target
- Divider line between categories

**Expanded State**:
- Smooth height transition (200ms ease-out)
- Item list with clear visual grouping
- Bottom padding to prevent last item from being obscured
- Subtle background tint to distinguish from collapsed sections

### 4. Item Row Component
Each inventory item (min 72px height for comfort):

**Layout Structure**:
- Left section (60% width):
  - Item name (text-base, font-normal)
  - SKU/code below (text-sm, muted)
- Right section (40% width):
  - Quantity controls (see below)

**Visual Treatment**:
- Subtle horizontal divider between items
- Active/selected state with background highlight
- Adequate padding (py-3, px-4)

### 5. Quantity Counter System
Dual-input design for boxes and singles:

**Layout** (Horizontal on mobile, can stack on very small screens):

**Box Counter**:
- Label: "Boxes" (text-xs, above)
- Decrement button: "-" (48x48px, rounded-lg)
- Count display: Large number (text-xl, 56px width, center-aligned, font-semibold)
- Increment button: "+" (48x48px, rounded-lg)
- All buttons with 3px spacing between

**Singles Counter** (same structure):
- Label: "Singles"
- Same button/display pattern

**Button Styling**:
- Border: 2px solid
- High contrast for visibility
- Active state: Scale down slightly (scale-95)
- Disabled state when at zero (for decrement)

**Alternative Input**:
- Tap on number to bring up numeric keyboard for direct entry
- Modal overlay with large number pad and "Done" button

### 6. Quick Action Bar (Bottom Fixed)
Floating action area (above safe zone):
- Primary action: "Save & Continue" (large, full-width on mobile)
- Secondary: "Save Draft" (text button, centered below primary)
- Position: Sticky bottom with safe-area padding
- Background: Solid with top shadow/gradient to indicate elevation
- Height: 88px minimum (accommodates buttons + padding)

### 7. Summary/Review Screen
Pre-submission review:
- Grouped by category (collapsible)
- Item counts displayed as "5 boxes, 23 singles"
- Edit button per category (navigates back)
- Grand total section at top (prominent card)
- Submit button (large, primary action)
- Warning indicators for zero counts or anomalies

### 8. Empty States
For categories with no items or searches:
- Centered icon (96x96px)
- Message (text-base)
- Suggested action if applicable
- Generous vertical padding (py-12)

### 9. Status Indicators
Visual feedback system:
- Success: Checkmark icon with semantic background
- Warning: Alert icon for unusual values
- In Progress: Animated pulse for active counting
- Complete: Badge with completion timestamp

### 10. Search/Filter Header
Collapsible search above category list:
- Search input: Full-width, 48px height, rounded corners
- Debounced filtering (300ms)
- Clear button inside input (when active)
- Results highlight matching text
- "X results found" counter

---

## Navigation Pattern

**Primary**: Single-screen navigation with modal overlays
- Categories expand/collapse in place
- Deep linking to specific categories via URL parameters
- Breadcrumb at top for context (Location > Category)

**Secondary**: Bottom sheet for actions
- Settings
- Help/Tutorial
- Export data
- Sign out

---

## Interactive Behaviors

**Scroll Performance**:
- Virtual scrolling for 100+ items (render only visible)
- Scroll restoration when navigating back
- Snap-to-top for active category header

**Touch Gestures**:
- Swipe right on item row: Quick +1 to singles
- Swipe left on item row: Quick -1 from singles
- Pull-to-refresh on category list
- Long-press on item: Show item details modal

**Haptic Feedback** (where supported):
- Light tap on increment/decrement
- Success pattern on save
- Error pattern on validation failure

**Loading States**:
- Skeleton screens for initial load
- Inline spinners for saves
- Toast messages for confirmations (bottom, 3s duration)

---

## Accessibility Implementation

- Minimum touch target: 48x48px (all interactive elements)
- Contrast ratio: 4.5:1 minimum for text
- Focus indicators: 3px outline on keyboard navigation
- Screen reader labels: All icons and actions
- Semantic HTML: Proper heading hierarchy, ARIA labels for counters
- Keyboard navigation: Tab order follows visual flow, Enter/Space to activate

---

## Images Section

**No large hero images** - This is a utility application focused on data entry efficiency.

**Icon System**:
- Use Material Icons (via CDN) for consistent iconography
- Category icons: 24x24px standard
- Action icons: 24x24px in buttons
- Status icons: 20x20px in badges
- Navigation: 24x24px

**Optional Visual Elements**:
- Location selection cards can include small location photos (thumbnail, 80x80px, rounded)
- Empty state illustrations (simple, single-color line art, 120x120px)

---

## Form Validation

- Inline validation for direct number entry
- Prevent negative values
- Warning prompts for unusually high counts (e.g., >1000)
- Unsaved changes warning before navigation
- Auto-save drafts every 30 seconds

---

## Performance Optimizations

- Lazy load category content
- Debounce counter updates
- Batch save operations
- Offline-first architecture messaging
- Optimistic UI updates (update display before server confirms)