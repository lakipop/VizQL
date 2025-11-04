# VizQL - Phase 1 Project Plan

## Overview

Phase 1 focuses on establishing the foundational architecture, UI/UX design system, and Docker infrastructure for VizQL. The goal is to create a fully functional frontend with mock data flows, setting the stage for real database integration in Phase 2.

## Objectives

1. **Establish Design System**: Implement a matte, professional, compact design theme
2. **Build Component Architecture**: Create reusable, well-structured Vue 3 components
3. **Implement Layout**: 3-column layout with header, sidebars, and main content
4. **Mock Data Flow**: Simulate query execution and data visualization
5. **Dockerize Application**: Ensure easy deployment and consistent development environment

## Design Specifications

### Theme: "Matte Professional Tool"

- **Philosophy**: Dense, compact, tool-focused (not website-like)
- **Background**: Very dark gray (`bg-gray-900`, `bg-black`)
- **Text**: Light matte gray (`text-gray-300`)
- **Accent 1 (Yellow)**: Matte desaturated yellow (`text-yellow-400`)
- **Accent 2 (Green)**: Natural matte green (`text-green-500`)
- **Typography**: Small and compact (`text-sm`, `text-xs`)
- **Spacing**: Tight padding (`p-2`, `p-1`)
- **Borders**: Thin, subtle borders

## Component Breakdown

### 1. AppHeader.vue
**Purpose**: Top navigation bar

**Features**:
- Centered "VizQL" logo/title
- Right-aligned action buttons ("Connect", "Settings")
- Thin horizontal layout
- Yellow/green accent colors for buttons

**Props**: None

**Events**: 
- `connect-clicked`
- `settings-clicked`

---

### 2. SidebarLeft.vue
**Purpose**: Navigation sidebar

**Features**:
- Thin vertical bar (left side)
- Mock navigation links:
  - Explorer
  - Queries
  - Dashboards
- Compact link styling
- Hover states with accent colors

**Props**: None

**Events**: 
- `navigate` (with destination)

---

### 3. SidebarRight.vue
**Purpose**: Database schema explorer

**Features**:
- Thin vertical bar (right side)
- "Database Schema" heading
- Placeholder text for future schema tree
- Compact styling

**Props**: 
- `schema` (optional, for future use)

**Events**: None

---

### 4. QueryEditor.vue
**Purpose**: SQL query input area

**Features**:
- Multi-line textarea for query input
- "Run Query" button with green accent
- Dark background with subtle border
- Compact, code-like font (monospace)
- Placeholder text: "Enter your SQL query here..."

**Props**: None

**Events**: 
- `run-query` (emits query text)

**State**:
- `query` (ref<string>): Current query text

---

### 5. ResultsTable.vue
**Purpose**: Display query results in table format

**Features**:
- Dynamic column headers from data keys
- Compact table rows
- Alternating row colors for readability
- Empty state message
- Responsive to data changes

**Props**: 
- `data` (array of objects): Query results

**Events**: None

**Computed**:
- `columns`: Extract column names from first data row

---

### 6. DataVisualizer.vue
**Purpose**: Chart visualization of data

**Features**:
- Bar chart using vue-chartjs
- Hardcoded sample data for Phase 1
- Dark theme chart styling
- Compact sizing

**Props**: 
- `data` (optional, for future use)

**Events**: None

---

### 7. app.vue
**Purpose**: Main application layout

**Features**:
- CSS Grid layout (3-column + header)
- Component placement:
  - Top: AppHeader
  - Left: SidebarLeft
  - Right: SidebarRight
  - Center: MainContent (router outlet)
- Responsive grid structure
- Dark background

---

### 8. pages/index.vue
**Purpose**: Main page with query workflow

**Features**:
- Query execution workflow
- Result display toggle (table/chart)
- Mock data handling
- State management for current view

**State**:
- `resultsData` (ref<any[] | null>): Query results
- `showChart` (ref<boolean>): Toggle between table and chart
- `queryText` (ref<string>): Current query

**Methods**:
- `handleRunQuery(query: string)`: Execute mock query
- `toggleView()`: Switch between table and chart

**Mock Data**:
```json
[
  { "id": 1, "name": "Product A", "sales": 1250, "region": "North" },
  { "id": 2, "name": "Product B", "sales": 890, "region": "South" },
  { "id": 3, "name": "Product C", "sales": 1560, "region": "East" },
  { "id": 4, "name": "Product D", "sales": 720, "region": "West" },
  { "id": 5, "name": "Product E", "sales": 1340, "region": "North" }
]
```

## Mock Data Flow

### User Journey:
1. **User enters query** in QueryEditor textarea
2. **User clicks "Run Query"** button
3. **QueryEditor emits** `run-query` event with query text
4. **index.vue handles event** and sets `resultsData` to mock JSON array
5. **ResultsTable displays** data in table format
6. **User toggles view** to switch to chart
7. **DataVisualizer displays** data as bar chart

### Data Flow Diagram:
```
User Input (QueryEditor)
    ↓
run-query Event
    ↓
index.vue Handler (handleRunQuery)
    ↓
Set resultsData = MOCK_DATA
    ↓
Conditional Render
    ├→ ResultsTable (if !showChart)
    └→ DataVisualizer (if showChart)
```

## Docker Configuration

### Services:

#### 1. vizql-app
- **Image**: Node 20 Alpine
- **Port**: 3000:3000
- **Volume**: ./app mounted to /app
- **Command**: npm run dev
- **Environment**: NODE_ENV=development

#### 2. vizql-db
- **Image**: mysql:latest
- **Port**: 3306:3306
- **Environment**:
  - MYSQL_ROOT_PASSWORD=root
  - MYSQL_DATABASE=vizql_db
  - MYSQL_USER=vizql_user
  - MYSQL_PASSWORD=vizql_pass
- **Volume**: Persistent data volume

### Dockerfile (Multi-stage):
1. **Build Stage**: Install dependencies and build Nuxt app
2. **Production Stage**: Copy build artifacts and run production server

## File Structure

```
VizQL/
├── app/
│   ├── components/
│   │   ├── AppHeader.vue
│   │   ├── SidebarLeft.vue
│   │   ├── SidebarRight.vue
│   │   ├── QueryEditor.vue
│   │   ├── ResultsTable.vue
│   │   └── DataVisualizer.vue
│   ├── pages/
│   │   └── index.vue
│   ├── app.vue
│   ├── nuxt.config.ts
│   ├── tailwind.config.ts
│   ├── package.json
│   └── tsconfig.json
├── docker-compose.yml
├── Dockerfile
├── README.md
└── PROJECT_PLAN_PHASE_1.md
```

## Dependencies

### Core:
- `nuxt` (^3.13.0)
- `vue` (^3.4.0)
- `typescript` (^5.3.0)

### Styling:
- `@nuxtjs/tailwindcss` (^6.12.0)
- `tailwindcss` (^3.4.0)

### Visualization:
- `vue-chartjs` (^5.3.0)
- `chart.js` (^4.4.0)

### Dev Dependencies:
- `@nuxt/types`
- `@types/node`

## Testing Checklist

- [ ] Docker containers start successfully
- [ ] Application accessible at localhost:3000
- [ ] Layout renders with all three columns
- [ ] Query editor accepts input
- [ ] "Run Query" button triggers data display
- [ ] ResultsTable renders mock data correctly
- [ ] Toggle switches between table and chart views
- [ ] DataVisualizer displays bar chart
- [ ] All styling matches matte theme
- [ ] Components are compact and dense
- [ ] Navigation elements are functional (placeholders)

## Success Criteria

Phase 1 is complete when:

1. ✅ All components are built and styled
2. ✅ Layout is fully responsive and functional
3. ✅ Mock data flow works end-to-end
4. ✅ Docker setup is working
5. ✅ Design system is consistently applied
6. ✅ Code is clean, typed, and documented

## Next Steps (Phase 2 Preview)

- Real MySQL connection implementation
- Query execution against actual database
- Schema introspection and display
- Error handling and validation
- Query result pagination
- Advanced chart types
- Query history and saved queries

---

**Phase 1 Timeline**: 1-2 days
**Status**: In Progress
