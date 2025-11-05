# 🚀 VizQL Phase 2 Setup Guide

## Phase 2 Complete! ✅

Your VizQL application now supports **live database connections**! This guide will help you get Phase 2 running.

---

## 📋 Prerequisites

Before starting, ensure you have:

- ✅ **Docker Desktop** installed and running
- ✅ **Node.js 20+** installed
- ✅ **npm 10+** installed
- ✅ **Git** (if cloning from repository)

---

## 🔧 Installation Steps

### Step 1: Install Dependencies

```bash
cd app
npm install
```

This installs `mysql2` and all other required packages.

### Step 2: Start Docker Services

```bash
# From project root
docker compose up
```

Wait for these messages:
```
vizql-db  | ready for connections. Version: '8.0.x'
vizql-app | Nuxt 3.x.x with Nitro 2.x.x
vizql-app | Local: http://localhost:3000
```

### Step 3: Open Application

Navigate to: **http://localhost:3000**

---

## 🎯 First-Time Setup

### Connect to Database

1. Click **"Connect"** button in the header
2. Use pre-filled Docker credentials:
   - **Host**: `vizql-db`
   - **Port**: `3306`
   - **Database**: `vizql_db`
   - **User**: `vizql_user`
   - **Password**: `vizql_pass`
3. Click **"Connect"**
4. ✅ You should see: Green "Connected" indicator
5. ✅ Right sidebar should show empty schema (no tables yet)

---

## 📊 Load Sample Data

### Option 1: Via VizQL UI (Recommended)

1. After connecting, paste this into the Query Editor:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  price DECIMAL(10,2),
  category VARCHAR(100)
);

INSERT INTO products (name, price, category) VALUES
  ('Laptop Pro', 1299.99, 'Electronics'),
  ('Wireless Mouse', 29.99, 'Electronics'),
  ('Office Desk', 399.99, 'Furniture'),
  ('Ergonomic Chair', 249.99, 'Furniture'),
  ('Cotton T-Shirt', 19.99, 'Clothing');
```

2. Click **"Run Query"** (or Ctrl+Enter)
3. ✅ Right sidebar should now show `products` table with 4 columns

### Option 2: Via Docker CLI

```bash
# From project root
docker exec -i vizql-db mysql -uvizql_user -pvizql_pass vizql_db < sample-data.sql
```

This loads a complete sample database with 5 tables and 200+ rows.

---

## 🧪 Test Queries

### Query 1: View Products
```sql
SELECT * FROM products;
```

### Query 2: Count by Category
```sql
SELECT category, COUNT(*) as count, AVG(price) as avg_price
FROM products
GROUP BY category;
```

### Query 3: Expensive Items
```sql
SELECT name, price, category
FROM products
WHERE price > 100
ORDER BY price DESC;
```

### Query 4: Database Info
```sql
SELECT DATABASE(), USER(), VERSION();
```

---

## 🎨 UI Features

### Connection Indicator
- **Green checkmark** = Connected
- **No indicator** = Not connected

### Loading States
- **Yellow spinner** = Query executing
- **Timestamp** = Last successful query

### Error Handling
- **Red banner** = Error occurred
- Click **X** to dismiss

### View Toggle
- **Table** = Tabular data display
- **Chart** = Bar chart visualization

---

## 🔍 Explore Schema

After connecting, the **right sidebar** shows:

```
products
  ├─ id (int) 🔑
  ├─ name (varchar(255))
  ├─ price (decimal(10,2))
  └─ category (varchar(100))
```

🔑 = Primary key

---

## 🐛 Troubleshooting

### "Connection refused"

**Cause**: Database not running

**Solution**:
```bash
docker ps  # Check if vizql-db is running
docker compose restart  # Restart services
```

### "Database not found"

**Cause**: Wrong database name

**Solution**: Use `vizql_db` (not `vizql-db`)

### "Access denied"

**Cause**: Wrong credentials

**Solution**: Use `vizql_user` / `vizql_pass`

### "Cannot find module 'mysql2'"

**Cause**: Dependencies not installed

**Solution**:
```bash
cd app
npm install
```

### TypeScript Lint Errors

**Cause**: VS Code cache issues

**Solution**:
1. Close VS Code
2. Delete `app/.nuxt` folder
3. Reopen VS Code
4. Run `npm run dev`

---

## 📁 New Files (Phase 2)

```
app/
├── composables/
│   └── useConnection.ts           ← Global state
├── components/
│   └── ConnectionModal.vue        ← Connection UI
└── server/
    └── api/
        ├── execute-query.post.ts  ← Query execution
        └── get-schema.post.ts     ← Schema fetch
```

---

## 🔄 Local Development (Without Docker)

If you want to run only the app locally:

### Step 1: Start External MySQL

Install and start MySQL on your machine.

### Step 2: Create Database

```sql
CREATE DATABASE vizql_local;
CREATE USER 'local_user'@'localhost' IDENTIFIED BY 'local_pass';
GRANT ALL PRIVILEGES ON vizql_local.* TO 'local_user'@'localhost';
```

### Step 3: Run App

```bash
cd app
npm run dev
```

### Step 4: Connect

Use these credentials in the connection modal:
- **Host**: `localhost`
- **Port**: `3306`
- **Database**: `vizql_local`
- **User**: `local_user`
- **Password**: `local_pass`

---

## 🌐 Remote Database Connection

VizQL can connect to **any accessible MySQL database**:

1. Ensure database allows remote connections
2. Get connection details from your DB provider
3. Use those credentials in the connection modal

**Example** (AWS RDS):
- **Host**: `mydb.123456.us-east-1.rds.amazonaws.com`
- **Port**: `3306`
- **Database**: `production_db`
- **User**: `admin`
- **Password**: `your-secure-password`

---

## 📚 Documentation

- **[Phase 2 Plan](../.documents/PROJECT_PLAN_PHASE_2.md)** - Full specifications
- **[Quick Reference](../.documents/PHASE_2_QUICKREF.md)** - Quick commands
- **[Migration Guide](../.documents/PHASE_2_MIGRATION.md)** - Phase 1 → 2 changes
- **[Troubleshooting](../.documents/TROUBLESHOOTING.md)** - Common issues

---

## 🚀 What's Next?

### Phase 3 Features (Coming Soon)
- ✨ Query history and favorites
- ✨ Connection pooling for speed
- ✨ Data export (CSV, JSON, Excel)
- ✨ Multiple chart types
- ✨ SQL syntax highlighting
- ✨ Performance metrics

---

## 🎉 Success Checklist

After setup, you should have:

- ✅ Docker containers running (`docker ps`)
- ✅ Application accessible at http://localhost:3000
- ✅ Successful database connection
- ✅ Schema visible in right sidebar
- ✅ Query execution working
- ✅ Table/Chart toggle functioning

---

## 💡 Tips

1. **Use Ctrl+Enter** to run queries quickly
2. **Start with simple queries** like `SELECT * FROM products LIMIT 10`
3. **Check schema** before writing queries
4. **Dismiss errors** by clicking X on error banner
5. **Toggle views** to see data differently

---

## ⚠️ Important Notes

### Security Warning
Phase 2 is for **development only**:
- No SQL injection prevention
- No authentication
- No rate limiting

**Do NOT use in production!**

### Connection Behavior
- New connection created for each query
- Connection automatically closed after query
- ~150ms overhead per query
- Phase 3 will add connection pooling

---

## 🆘 Need Help?

1. Check [TROUBLESHOOTING.md](../.documents/TROUBLESHOOTING.md)
2. View Docker logs: `docker compose logs -f`
3. Check browser console (F12)
4. Verify database is running: `docker ps`

---

**Phase 2 is ready! Start querying! 🚀**

*Last Updated: November 5, 2025*
