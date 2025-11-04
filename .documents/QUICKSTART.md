# VizQL - Quick Start Guide

## Prerequisites

Before you begin, ensure you have the following installed:
- **Docker** (version 20.10 or higher)
- **Docker Compose** (version 2.0 or higher)

Check your versions:
```bash
docker --version
docker-compose --version
```

## Quick Start

### 1. Navigate to the project directory
```bash
cd VizQL
```

### 2. Start the application
```bash
docker-compose up
```

This command will:
- Build the Nuxt 3 application container
- Start the MySQL database container
- Install all dependencies
- Start the development server

### 3. Access the application
Once the containers are running, open your browser and navigate to:
- **VizQL Application**: http://localhost:3000

You should see the VizQL interface with:
- Header with "VizQL" logo
- Left sidebar with navigation
- Right sidebar showing "Database Schema"
- Main content area with Query Editor

### 4. Test the application

#### Run a Mock Query
1. In the Query Editor (top half of main content), type any SQL query:
   ```sql
   SELECT * FROM products;
   ```
2. Click the **"Run Query"** button (green button with play icon)
3. See the mock data displayed in the Results Table below

#### Toggle Between Views
- Click the **"Table"** button to view data in table format
- Click the **"Chart"** button to view data as a bar chart

## Stopping the Application

To stop the application:
```bash
# Press Ctrl+C in the terminal where docker-compose is running

# Or run this in another terminal:
docker-compose down
```

## Development Mode

If you want to run the app locally without Docker:

### 1. Install dependencies
```bash
cd app
npm install
```

### 2. Run development server
```bash
npm run dev
```

### 3. Access the application
Open http://localhost:3000

## Troubleshooting

### Port 3000 is already in use
If port 3000 is occupied, you can change it in `docker-compose.yml`:
```yaml
ports:
  - "3001:3000"  # Change 3001 to any available port
```

### Port 3306 is already in use (MySQL)
If you have MySQL running locally, either:
1. Stop your local MySQL, or
2. Change the port in `docker-compose.yml`:
```yaml
ports:
  - "3307:3306"  # Change 3307 to any available port
```

### Containers won't start
Try rebuilding:
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up
```

### Node modules issues
Remove volumes and rebuild:
```bash
docker-compose down -v
docker-compose up --build
```

## Project Structure Overview

```
VizQL/
├── app/                       # Nuxt 3 application
│   ├── components/            # Vue components
│   │   ├── AppHeader.vue      # Top header bar
│   │   ├── SidebarLeft.vue    # Left navigation sidebar
│   │   ├── SidebarRight.vue   # Right schema sidebar
│   │   ├── QueryEditor.vue    # SQL query input
│   │   ├── ResultsTable.vue   # Table view of results
│   │   └── DataVisualizer.vue # Chart visualization
│   ├── pages/
│   │   └── index.vue          # Main page with query workflow
│   ├── assets/css/
│   │   └── main.css           # Tailwind styles
│   ├── app.vue                # Main layout
│   ├── nuxt.config.ts         # Nuxt configuration
│   ├── tailwind.config.ts     # Tailwind theme
│   └── package.json           # Dependencies
├── docker-compose.yml         # Docker services
├── Dockerfile                 # App container config
└── README.md                  # Project documentation
```

## What's Included in Phase 1

✅ **Complete UI Layout**
- 3-column design (header, left sidebar, main content, right sidebar)
- Matte, professional dark theme
- Compact, tool-focused styling

✅ **Components**
- Query Editor with syntax highlighting
- Results Table with sortable columns
- Data Visualizer with bar chart
- Navigation sidebars

✅ **Mock Data Flow**
- Query execution simulation
- Toggle between table and chart views
- Timestamp tracking

✅ **Docker Setup**
- Containerized Nuxt 3 app
- MySQL database (ready for Phase 2)
- Easy deployment with docker-compose

## Next Steps

Phase 1 focuses on UI and mock data. In Phase 2, we'll implement:
- Real database connections
- Schema introspection
- Query execution against actual databases
- Error handling and validation

## Need Help?

Check the following files for more details:
- `README.md` - Project overview
- `PROJECT_PLAN_PHASE_1.md` - Detailed Phase 1 specifications

Enjoy building with VizQL! 🚀
