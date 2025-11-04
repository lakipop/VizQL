# VizQL - Development Guide

## Overview
This guide covers development workflows, testing procedures, and best practices for the VizQL project.

## Development Setup

### Option 1: Docker Development (Recommended)

1. **Start the development environment:**
```bash
docker-compose up
```

2. **View logs:**
```bash
docker-compose logs -f vizql-app
```

3. **Rebuild after dependency changes:**
```bash
docker-compose up --build
```

### Option 2: Local Development

1. **Install dependencies:**
```bash
cd app
npm install
```

2. **Run development server:**
```bash
npm run dev
```

3. **Build for production:**
```bash
npm run build
```

4. **Preview production build:**
```bash
npm run preview
```

## Project Architecture

### Component Hierarchy

```
app.vue (Main Layout)
├── AppHeader (Top Bar)
├── SidebarLeft (Navigation)
├── SidebarRight (Schema)
└── NuxtPage (Router Outlet)
    └── pages/index.vue (Main Page)
        ├── QueryEditor
        └── Conditional:
            ├── ResultsTable (Table View)
            └── DataVisualizer (Chart View)
```

### Data Flow

```
User Input → QueryEditor
             ↓ (emit: run-query)
          index.vue (handler)
             ↓ (set: resultsData)
       Conditional Render
             ↓
    ResultsTable OR DataVisualizer
```

## Component API Reference

### QueryEditor.vue

**Emits:**
- `run-query(query: string)` - Fired when user clicks "Run Query" or presses Ctrl+Enter

**Features:**
- Auto-resize textarea
- Character counter
- Keyboard shortcut (Ctrl+Enter)
- Placeholder with example SQL

### ResultsTable.vue

**Props:**
- `data: any[] | null` - Array of objects to display

**Features:**
- Dynamic column generation
- Empty state handling
- Alternating row colors
- Sticky header

### DataVisualizer.vue

**Props:**
- `data?: any[] | null` - Optional data for chart (uses mock if not provided)

**Features:**
- Bar chart visualization
- Dark theme styling
- Responsive sizing
- Configurable options

### SidebarLeft.vue

**Emits:**
- `navigate(destination: string)` - Fired when user clicks navigation item

**Features:**
- Icon + label navigation
- Active state highlighting
- Hover effects

### SidebarRight.vue

**Props:**
- `schema?: any` - Optional schema data (for Phase 2)

**Features:**
- Placeholder for schema tree
- Mock tree structure display

### AppHeader.vue

**Emits:**
- `connect-clicked()` - Fired when "Connect" button clicked
- `settings-clicked()` - Fired when "Settings" button clicked

**Features:**
- Logo with brand colors
- Action buttons
- Icon integration

## Styling Guide

### Theme Variables

The project uses Tailwind CSS with custom theme extensions:

**Background Colors:**
- `bg-black` - Main content area
- `bg-gray-900` - Sidebars and components
- `bg-gray-800` - Hover states

**Text Colors:**
- `text-gray-300` - Primary text
- `text-gray-400` - Secondary text
- `text-gray-600` - Tertiary text
- `text-yellow-400` - Primary accent (VizQL brand)
- `text-green-500` - Secondary accent (actions)

**Font Sizes:**
- `text-xxs` - 10px - Very compact labels
- `text-xs` - 12px - Small labels
- `text-sm` - 14px - Body text (default)
- `text-base` - 14px - Overridden to be small

**Spacing:**
- Use `p-2`, `p-3` for padding (compact)
- Use `space-x-2`, `space-y-2` for gaps
- Avoid large spacing to maintain "tool" feel

### Component Styling Pattern

```vue
<style scoped>
/* Container */
.component-container {
  @apply flex flex-col h-full border border-gray-800 rounded bg-gray-900;
}

/* Header */
.component-header {
  @apply flex items-center justify-between px-3 py-2 border-b border-gray-800;
}

/* Button */
.component-btn {
  @apply flex items-center px-2 py-1 text-xs rounded;
  @apply border border-gray-700 text-gray-400;
  @apply hover:bg-gray-800 transition-all duration-150;
  @apply focus:outline-none focus:ring-1 focus:ring-yellow-400;
}
</style>
```

## Testing Phase 1 Features

### Manual Testing Checklist

#### 1. Layout & Responsiveness
- [ ] Header appears at top with logo and buttons
- [ ] Left sidebar shows navigation items
- [ ] Right sidebar shows schema placeholder
- [ ] Main content area fills remaining space
- [ ] Layout adjusts on window resize

#### 2. Query Editor
- [ ] Textarea accepts multi-line input
- [ ] Character counter updates as you type
- [ ] "Run Query" button is disabled when empty
- [ ] Ctrl+Enter triggers query execution
- [ ] Button shows hover and focus states

#### 3. Results Display
- [ ] Empty state shows before running query
- [ ] After running query, mock data appears
- [ ] Table view shows all columns and rows
- [ ] Table has sticky header
- [ ] Row hover effects work
- [ ] Alternating row colors visible

#### 4. Chart Visualization
- [ ] Toggle to "Chart" button switches view
- [ ] Bar chart renders correctly
- [ ] Chart uses dark theme colors
- [ ] Tooltips appear on hover
- [ ] Legend is visible

#### 5. Navigation & Interactions
- [ ] "Connect" button shows hover effect
- [ ] "Settings" button shows hover effect
- [ ] Navigation items highlight on hover
- [ ] Console logs show navigation clicks

#### 6. Theme & Styling
- [ ] Dark background throughout
- [ ] Yellow and green accents visible
- [ ] Text is readable (good contrast)
- [ ] Borders are thin and subtle
- [ ] Components feel compact
- [ ] Font sizes are small

### Mock Data Testing

The application uses this mock data structure:

```javascript
[
  { 
    id: 1, 
    name: 'Product A', 
    sales: 1250, 
    region: 'North', 
    category: 'Electronics' 
  },
  // ... more items
]
```

**Test scenarios:**
1. Verify all 7 rows appear
2. Check all 5 columns display
3. Confirm data accuracy in table
4. Verify chart displays sales values
5. Check labels match product names

## Common Development Tasks

### Adding a New Component

1. Create component file in `app/components/`:
```vue
<template>
  <div class="my-component">
    <!-- Component content -->
  </div>
</template>

<script setup lang="ts">
// Component logic
</script>

<style scoped>
/* Component styles */
</style>
```

2. Import and use (auto-imported by Nuxt):
```vue
<template>
  <MyComponent />
</template>
```

### Adding a New Page

1. Create page file in `app/pages/`:
```vue
<!-- app/pages/about.vue -->
<template>
  <div>About page</div>
</template>
```

2. Access at `/about` route automatically

### Modifying Theme Colors

Edit `app/tailwind.config.ts`:

```typescript
theme: {
  extend: {
    colors: {
      'vizql': {
        'new-color': '#hexcode',
      }
    }
  }
}
```

### Adding Dependencies

1. Add to `app/package.json`
2. Rebuild Docker container:
```bash
docker-compose down
docker-compose up --build
```

Or for local development:
```bash
cd app
npm install
```

## Debugging Tips

### View Component State
Use Vue DevTools browser extension to inspect:
- Component hierarchy
- Component props and state
- Events and their payloads

### Console Logging
Key events are logged:
- Query execution: Check console for "Executing query:"
- Mock data return: Check console for "Mock data returned:"
- Navigation: Check console for "Navigate to:"

### Docker Debugging

**View container logs:**
```bash
docker-compose logs -f vizql-app
```

**Access container shell:**
```bash
docker exec -it vizql-app sh
```

**Check running containers:**
```bash
docker ps
```

**Rebuild specific service:**
```bash
docker-compose up --build vizql-app
```

## Performance Considerations

### Phase 1 Optimizations
- Components use `scoped` styles (CSS isolation)
- Computed properties for derived data
- Minimal re-renders with Vue 3 reactivity
- Lazy loading ready (for future phases)

### Monitoring
Watch for:
- Memory usage in DevTools
- Network requests (should be minimal in Phase 1)
- Component render times

## Code Quality

### TypeScript Usage
- All components use `<script setup lang="ts">`
- Props defined with TypeScript interfaces
- Emits typed for autocomplete

### Vue 3 Composition API
- Use `ref()` for reactive state
- Use `computed()` for derived state
- Use `watch()` for side effects (if needed)

### Best Practices
- Keep components small and focused
- Use semantic HTML
- Maintain consistent naming
- Follow Tailwind utility-first approach
- Comment complex logic

## Preparing for Phase 2

Phase 1 sets up the foundation. For Phase 2, we'll need:

1. **Database Connection Logic**
   - MySQL client integration
   - Connection pool management
   - Query execution engine

2. **Schema Introspection**
   - Fetch tables, columns, relationships
   - Display in SidebarRight
   - Enable click-to-insert functionality

3. **Error Handling**
   - Query validation
   - Connection error states
   - User-friendly error messages

4. **Advanced Features**
   - Query history
   - Saved queries
   - Export results
   - Multiple chart types

## Git Workflow

### Branching Strategy (Recommended)

```bash
main           # Production-ready code
├── develop    # Development branch
│   ├── feature/query-history
│   ├── feature/schema-viewer
│   └── bugfix/table-sorting
```

### Commit Message Format

```
type(scope): brief description

Detailed explanation if needed

Types: feat, fix, docs, style, refactor, test, chore
```

Example:
```
feat(QueryEditor): add syntax highlighting

Implemented SQL syntax highlighting using Monaco Editor
for better query writing experience.
```

## Deployment

### Production Build

1. **Build the application:**
```bash
cd app
npm run build
```

2. **Test production build locally:**
```bash
npm run preview
```

3. **Docker production image:**
```bash
docker build -t vizql:latest .
docker run -p 3000:3000 vizql:latest
```

### Environment Variables

Create `.env` file for production:
```env
NODE_ENV=production
DB_HOST=your-db-host
DB_PORT=3306
DB_NAME=your-db-name
DB_USER=your-db-user
DB_PASSWORD=your-secure-password
```

## Support & Resources

- **Nuxt 3 Docs**: https://nuxt.com/docs
- **Vue 3 Docs**: https://vuejs.org/guide
- **Tailwind CSS**: https://tailwindcss.com/docs
- **Chart.js**: https://www.chartjs.org/docs
- **TypeScript**: https://www.typescriptlang.org/docs

---

Happy coding! 🚀
