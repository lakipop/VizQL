# VizQL Phase 2 - Quick Reference

## 🎯 What Changed?

Phase 2 replaces **mock data** with **live database connections**.

---

## ⚡ Quick Start

### 1. Install Dependencies
```bash
cd app
npm install
```

### 2. Start Docker (Database + App)
```bash
docker compose up
```

### 3. Connect to Database
1. Open http://localhost:3000
2. Click **"Connect"** button
3. Use pre-filled values (vizql-db, 3306, vizql_db, vizql_user, vizql_pass)
4. Click **"Connect"**

### 4. Run Queries
```sql
SELECT DATABASE(), USER(), VERSION();
```

---

## 📁 New Files

```
app/
├── composables/
│   └── useConnection.ts          ← Global connection state
├── components/
│   └── ConnectionModal.vue       ← Database connection UI
└── server/
    └── api/
        ├── execute-query.post.ts ← Query execution endpoint
        └── get-schema.post.ts    ← Schema introspection endpoint
```

---

## 🔄 Modified Files

| File | Change |
|------|--------|
| `package.json` | Added `mysql2` dependency |
| `AppHeader.vue` | Opens modal via composable |
| `SidebarRight.vue` | Displays live schema |
| `pages/index.vue` | Orchestrates connection + queries |
| `QueryEditor.vue` | Added `disabled` prop |
| `app.vue` | Passes schema to sidebar |

---

## 🗄️ Connection Details (Docker)

| Field | Value |
|-------|-------|
| **Host** | `vizql-db` |
| **Port** | `3306` |
| **Database** | `vizql_db` |
| **User** | `vizql_user` |
| **Password** | `vizql_pass` |

---

## 🧪 Test Queries

### Check Connection
```sql
SELECT DATABASE(), USER(), VERSION();
```

### Create Sample Table
```sql
CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  price DECIMAL(10,2),
  category VARCHAR(100)
);
```

### Insert Data
```sql
INSERT INTO products (name, price, category) VALUES
  ('Laptop', 999.99, 'Electronics'),
  ('Mouse', 29.99, 'Electronics'),
  ('Desk', 299.99, 'Furniture');
```

### Query Data
```sql
SELECT * FROM products;
```

### Aggregation
```sql
SELECT category, COUNT(*) as count, AVG(price) as avg_price
FROM products
GROUP BY category;
```

---

## 🎨 UI Flow

```
1. Click "Connect" → Modal opens
2. Fill credentials → Click "Connect"
3. Schema loads in right sidebar
4. Type SQL query → Click "Run Query"
5. Results appear in table view
6. Toggle to "Chart" for visualization
```

---

## ⚠️ Troubleshooting

### "Connection refused"
- Check if Docker is running: `docker ps`
- Restart: `docker compose restart`

### "Database not found"
- Verify database name: `vizql_db`
- Check logs: `docker compose logs vizql-db`

### "mysql2 not found"
- Install dependencies: `cd app && npm install`

### TypeScript errors
- Restart VS Code
- Run `npm install` again

---

## 🚀 What's Next (Phase 3)?

- Query history and favorites
- Connection pooling
- Data export (CSV, JSON)
- Multiple chart types
- SQL syntax highlighting
- Performance metrics

---

**Phase 2 is LIVE! 🎉**

*Full docs: [PROJECT_PLAN_PHASE_2.md](PROJECT_PLAN_PHASE_2.md)*
