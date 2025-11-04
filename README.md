# VizQL

> A modern, lightweight database query visualization tool - your personal "mini Power BI"

**VizQL** transforms the way you interact with your databases. Write SQL queries, visualize results instantly, and gain insights from your data - all within a sleek, professional interface designed for developers and data analysts.

---

## 🌟 Vision

VizQL aims to be the **go-to open-source alternative** to heavyweight business intelligence tools. We believe data visualization should be:
- **Fast** - No bloated interfaces, just pure functionality
- **Simple** - Write SQL, see results, create charts
- **Beautiful** - A professional dark theme that's easy on the eyes
- **Free** - Open source and always will be

---

## ✨ Current Features (Phase 1 - Foundation)

### 🎨 Professional UI/UX
- **Sleek Dark Theme**: Complete black background (`zinc-950`) with clean white sidebars
- **3-Column Layout**: 
  - Left sidebar for navigation
  - Center for query editor and results
  - Right sidebar for database schema (coming in Phase 2)
- **Compact Design**: Every pixel optimized for maximum workspace

### 📝 Query Editor
- Multi-line SQL editor with monospace font
- Real-time character counter
- Keyboard shortcut support (Ctrl+Enter to run)
- Syntax-ready for SQL queries

### 📊 Data Visualization
- **Table View**: Clean, responsive data tables with sticky headers
- **Chart View**: Bar charts with dark theme integration (via Chart.js)
- **Instant Toggle**: Switch between table and chart with one click
- **Mock Data**: Currently demonstrates functionality with sample product data

### 🎯 Developer-Friendly
- Built with **Nuxt 3** and **Vue 3** Composition API
- Fully typed with **TypeScript**
- Styled with **Tailwind CSS 4** (no PostCSS bloat)
- Hot reload for rapid development
- Component-based architecture

---

## 🚀 What's Working Now

✅ Complete UI with professional matte design  
✅ Query editor with keyboard shortcuts  
✅ Mock query execution workflow  
✅ Table and chart visualization toggle  
✅ Responsive layout  
✅ Hot module replacement (HMR)  
✅ TypeScript strict mode  
✅ Component auto-import  

---

## 🎯 Roadmap

### Phase 2: Database Integration (Next)
- [ ] Real MySQL/PostgreSQL connections
- [ ] Schema introspection and explorer
- [ ] Live query execution
- [ ] Connection management UI
- [ ] Query result pagination
- [ ] Error handling and validation

### Phase 3: Advanced Features
- [ ] Query history and favorites
- [ ] Multiple database connections
- [ ] Export results (CSV, JSON, Excel)
- [ ] Multiple chart types (pie, line, scatter)
- [ ] Query templates and snippets
- [ ] Syntax highlighting

### Phase 4: Collaboration & Intelligence
- [ ] Saved dashboards
- [ ] Shareable query links
- [ ] Multi-user support
- [ ] Query performance insights
- [ ] AI-assisted query generation
- [ ] Scheduled queries

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Nuxt 3 + Vue 3 |
| **Language** | TypeScript (Strict Mode) |
| **Styling** | Tailwind CSS 4 |
| **Charts** | Chart.js + vue-chartjs |
| **Database** | MySQL (PostgreSQL coming soon) |
| **Deployment** | Docker + Docker Compose |

---

## 🚦 Getting Started

### Prerequisites
- **Node.js** 20+ (or Docker)
- **npm** 10+
- **Docker** (optional, for containerized setup)

### Quick Start (Local Development)

```bash
# Clone the repository
git clone <repository-url>
cd VizQL

# Navigate to app directory
cd app

# Install dependencies
npm install

# Start development server
npm run dev
```

**Open your browser**: http://localhost:3000

### Docker Setup (Alternative)

```bash
# Start both app and database
docker compose up

# Access application
# http://localhost:3000
```

### Try It Out!
1. Type any SQL query in the editor (it's mock data for now):
   ```sql
   SELECT * FROM products WHERE sales > 1000;
   ```
2. Click **"Run Query"** or press `Ctrl+Enter`
3. See results in table format
4. Click **"Chart"** to visualize as a bar chart
5. Toggle back to **"Table"** view

---

## 📂 Project Structure

```
VizQL/
├── app/
│   ├── components/          # Vue 3 components
│   │   ├── AppHeader.vue    # Top navigation
│   │   ├── SidebarLeft.vue  # Navigation sidebar
│   │   ├── SidebarRight.vue # Schema explorer (Phase 2)
│   │   ├── QueryEditor.vue  # SQL editor
│   │   ├── ResultsTable.vue # Table display
│   │   └── DataVisualizer.vue # Chart visualization
│   ├── pages/
│   │   └── index.vue        # Main application page
│   ├── assets/css/
│   │   └── main.css         # Global styles
│   ├── nuxt.config.ts       # Nuxt configuration
│   ├── tailwind.config.ts   # Theme customization
│   └── package.json         # Dependencies
├── docker-compose.yml       # Docker services
├── Dockerfile              # App container
└── README.md               # You are here
```

---

## 🎨 Design Philosophy

VizQL is designed as a **professional tool**, not a website:

- **Dense**: Maximum information in minimal space
- **Compact**: Small fonts (12-14px), tight spacing
- **Matte**: No bright colors, no glossy effects
- **Functional**: Every pixel serves a purpose
- **Fast**: Instant feedback, minimal animations
- **Dark**: Zinc-950 black with white sidebars for contrast

**Inspiration**: VS Code, DataGrip, Postico - tools developers love.

---

## 🤝 Contributing

VizQL is in active development! Contributions are welcome.

### Areas We Need Help
- [ ] PostgreSQL adapter implementation
- [ ] Additional chart types
- [ ] Query autocomplete/IntelliSense
- [ ] Documentation improvements
- [ ] Testing (unit & e2e)

### How to Contribute
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📊 Current Progress

**Phase 1**: ████████████████████ 100% Complete ✅

**Overall Project**: ████░░░░░░░░░░░░░░░░ 20% Complete

- ✅ UI/UX Foundation
- ✅ Component Architecture
- ✅ Mock Data Flow
- ⏳ Database Integration (Phase 2 - Next)
- ⏳ Advanced Features (Phase 3)
- ⏳ Collaboration Tools (Phase 4)

---

## 📖 Documentation

- **[Quick Start Guide](QUICKSTART.md)** - Get up and running in 5 minutes
- **[Development Guide](DEVELOPMENT.md)** - Component API, styling, debugging
- **[Project Plan](PROJECT_PLAN_PHASE_1.md)** - Detailed Phase 1 specifications
- **[Troubleshooting](TROUBLESHOOTING.md)** - Common issues and solutions

---

## 📜 License

MIT License - See [LICENSE](LICENSE) for details

---

## 🌐 Community & Support

- **Issues**: Found a bug? [Open an issue](../../issues)
- **Discussions**: Have ideas? [Start a discussion](../../discussions)
- **Updates**: Follow development progress on the [roadmap](../../projects)

---

## 🙏 Acknowledgments

Built with:
- [Nuxt 3](https://nuxt.com) - The Intuitive Vue Framework
- [Vue 3](https://vuejs.org) - The Progressive JavaScript Framework
- [Tailwind CSS](https://tailwindcss.com) - Utility-First CSS Framework
- [Chart.js](https://www.chartjs.org) - Simple yet flexible charting

---

**⭐ Star this repo** if you find VizQL useful! It helps us grow the community.

**Made with ❤️ by developers, for developers**

---

*VizQL - Query. Visualize. Understand.*
