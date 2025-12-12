# Docker Guide for VizQL 🐳

> A beginner-friendly guide to understanding and using Docker with VizQL

---

## 📚 Table of Contents

1. [What is Docker?](#-what-is-docker)
2. [Why Docker for VizQL?](#-why-docker-for-vizql)
3. [Key Docker Concepts](#-key-docker-concepts)
4. [VizQL Docker Architecture](#-vizql-docker-architecture)
5. [Understanding the Files](#-understanding-the-files)
6. [How to Use Docker with VizQL](#-how-to-use-docker-with-vizql)
7. [Common Commands](#-common-commands)
8. [Troubleshooting](#-troubleshooting)
9. [Glossary](#-glossary)

---

## 🤔 What is Docker?

Think of Docker as a **shipping container for software**. Just like shipping containers allow goods to be transported anywhere in the world regardless of what ship, truck, or train carries them, Docker containers allow your application to run anywhere regardless of the host system.

### The Problem Docker Solves

Without Docker:
- "It works on my machine!" 😅
- Installing MySQL, Node.js, and all dependencies manually
- Different developers have different versions of software
- Production environment differs from development

With Docker:
- ✅ Same environment everywhere (your laptop, teammate's laptop, production server)
- ✅ All dependencies packaged together
- ✅ One command to start everything
- ✅ No "it works on my machine" problems

### Real-World Analogy

Imagine you're moving houses:
- **Without Docker**: You pack items loose in a truck. Some break, some get lost, and unpacking takes forever.
- **With Docker**: You use standardized moving boxes. Everything is organized, protected, and easy to unpack at your new home.

---

## 💡 Why Docker for VizQL?

VizQL needs **two things** to work:
1. **Application Server** (Nuxt 3 / Node.js) - Runs the web interface
2. **Database Server** (MySQL) - Stores and retrieves data

Setting these up manually is tedious:
- Install Node.js 20+
- Install MySQL 8.0+
- Configure MySQL users, passwords, databases
- Set environment variables
- Deal with port conflicts

**With Docker, it's just ONE command:**
```bash
docker compose up
```

That's it! Both services start automatically, pre-configured and ready to use.

---

## 🧊 Key Docker Concepts

### 1. Container 📦

A **container** is like a lightweight, isolated computer running inside your computer.

```
┌─────────────────────────────────────┐
│         Your Computer (Host)         │
│  ┌──────────────┐ ┌──────────────┐  │
│  │  Container 1 │ │  Container 2 │  │
│  │   (VizQL)    │ │   (MySQL)    │  │
│  └──────────────┘ └──────────────┘  │
└─────────────────────────────────────┘
```

Key properties:
- **Isolated**: Containers can't accidentally interfere with each other
- **Lightweight**: Uses less resources than a full virtual machine
- **Portable**: Runs the same way on Windows, Mac, or Linux

### 2. Image 🖼️

An **image** is a blueprint/recipe for creating containers. Think of it like:
- Image = Recipe for a cake 📝
- Container = The actual cake you baked 🎂

Common images used in VizQL:
- `node:20-alpine` - Node.js 20 on Alpine Linux (small and fast)
- `mysql:latest` - Latest version of MySQL

### 3. Dockerfile 📄

A **Dockerfile** is a text file with step-by-step instructions to build an image.

Think of it like assembly instructions for IKEA furniture:
1. Start with a base (shelf boards)
2. Add your items (screws, brackets)
3. Put it together (npm install)
4. Final product (ready-to-run app)

### 4. Docker Compose 🎼

**Docker Compose** is like an orchestra conductor. It:
- Coordinates multiple containers to work together
- Defines how containers communicate with each other
- Starts everything with one command

---

## 🏗️ VizQL Docker Architecture

Here's how VizQL's Docker setup works:

```
                          ┌─────────────────────────┐
                          │     Your Browser         │
                          │   http://localhost:3000  │
                          └───────────┬─────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────┐
│                     DOCKER COMPOSE                           │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                  vizql-network                         │  │
│  │                                                        │  │
│  │  ┌──────────────────┐         ┌──────────────────┐    │  │
│  │  │   vizql-app      │         │    vizql-db      │    │  │
│  │  │   ────────────   │ ◄─────► │   ────────────   │    │  │
│  │  │   Nuxt 3 App     │         │   MySQL 8.0      │    │  │
│  │  │                  │         │                  │    │  │
│  │  │   Port: 3000     │         │   Port: 3306     │    │  │
│  │  └──────────────────┘         └──────────────────┘    │  │
│  │                                                        │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Volume: vizql-db-data (Persistent Database Storage)   │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### How the Flow Works

1. **You** open http://localhost:3000 in your browser
2. **Docker** routes the request to the `vizql-app` container (port 3000)
3. **vizql-app** serves the VizQL web interface
4. **When you run a query**, `vizql-app` connects to `vizql-db` using the internal Docker network
5. **vizql-db** executes the SQL query and returns results
6. **vizql-app** displays the results in your browser

### Two Containers Working Together

| Container | What It Does | Based On | Exposed Port |
|-----------|--------------|----------|--------------|
| **vizql-app** | Runs the Nuxt 3 web application | `node:20-alpine` | 3000 |
| **vizql-db** | Runs the MySQL database | `mysql:latest` | 3306 |

---

## 📄 Understanding the Files

### File 1: `Dockerfile`

Location: `VizQL/Dockerfile`

This file tells Docker how to build the **VizQL application container**.

```dockerfile
# ==========================================
# STAGE 1: Build the application
# ==========================================
FROM node:20-alpine AS builder
# Start with Node.js 20 on Alpine Linux (small, efficient)

WORKDIR /app
# Set working directory inside the container

COPY app/package*.json ./
# Copy package.json and package-lock.json first

RUN npm ci
# Install dependencies (clean install, faster than npm install)

COPY app/ .
# Copy all application files

RUN npm run build
# Build the Nuxt 3 application for production

# ==========================================
# STAGE 2: Production image (smaller)
# ==========================================
FROM node:20-alpine
# Fresh, clean Node.js image

WORKDIR /app

COPY app/package*.json ./
RUN npm ci --only=production
# Install ONLY production dependencies (smaller size)

COPY --from=builder /app/.output ./.output
# Copy built application from Stage 1

EXPOSE 3000
# Tell Docker this app uses port 3000

ENV NODE_ENV=production

CMD ["node", ".output/server/index.mjs"]
# Start the application
```

**Why Two Stages?**

This is called a **multi-stage build**. It makes the final image smaller:
- Stage 1 installs ALL dependencies (including dev tools) and builds the app
- Stage 2 only includes production dependencies and the built app
- Result: Smaller, faster, more secure container

---

### File 2: `docker-compose.yml`

Location: `VizQL/docker-compose.yml`

This file defines how to run **multiple containers together**.

```yaml
services:
  # ==========================================
  # SERVICE 1: The VizQL Application
  # ==========================================
  vizql-app:
    build:
      context: .              # Build from current directory
      dockerfile: Dockerfile  # Use our Dockerfile
    container_name: vizql-app
    ports:
      - "3000:3000"           # Map localhost:3000 → container:3000
    volumes:
      - ./app:/app            # Sync local app folder with container
      - /app/node_modules     # Don't sync node_modules
      - /app/.nuxt            # Don't sync .nuxt cache
    environment:
      - NODE_ENV=development
      - DB_HOST=vizql-db      # Database is at hostname "vizql-db"
      - DB_PORT=3306
      - DB_NAME=vizql_db
      - DB_USER=vizql_user
      - DB_PASSWORD=vizql_pass
    depends_on:
      - vizql-db              # Wait for database to start first
    command: npm run dev      # Run dev server (with hot reload)
    networks:
      - vizql-network         # Use our custom network

  # ==========================================
  # SERVICE 2: The MySQL Database
  # ==========================================
  vizql-db:
    image: mysql:latest       # Use official MySQL image
    container_name: vizql-db
    ports:
      - "3306:3306"           # Map localhost:3306 → MySQL
    environment:
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_DATABASE=vizql_db      # Create this database on start
      - MYSQL_USER=vizql_user        # Create this user
      - MYSQL_PASSWORD=vizql_pass    # With this password
    volumes:
      - vizql-db-data:/var/lib/mysql # Persist data between restarts
    networks:
      - vizql-network
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      timeout: 20s
      retries: 10             # Keep trying until MySQL is ready

# ==========================================
# PERSISTENT STORAGE
# ==========================================
volumes:
  vizql-db-data:
    driver: local             # Store database files on your computer

# ==========================================
# NETWORKING
# ==========================================
networks:
  vizql-network:
    driver: bridge            # Private network for our containers
```

**Key Concepts Explained:**

| Concept | What It Means |
|---------|---------------|
| `ports: "3000:3000"` | Left = your computer, Right = container |
| `volumes` | Sync files between your computer and container |
| `depends_on` | Start database before the app |
| `networks` | Private network so containers can talk to each other |
| `healthcheck` | Verify the database is actually ready |

---

### File 3: `.dockerignore`

Location: `VizQL/.dockerignore`

This file tells Docker which files to **skip** when building images (like `.gitignore` for Docker).

```
# Skip documentation (not needed in container)
*.md
docs/

# Skip version control
.git/
.gitignore

# Skip IDE settings
.vscode/
.idea/

# Skip logs
*.log
logs/
```

**Why Ignore Files?**

- **Faster builds**: Less files to copy
- **Smaller images**: Don't include unnecessary files
- **Security**: Don't include sensitive config files

---

## 🚀 How to Use Docker with VizQL

### Prerequisites

1. **Install Docker Desktop**
   - Windows: [Download Docker Desktop](https://docker.com/products/docker-desktop/)
   - Mac: [Download Docker Desktop](https://docker.com/products/docker-desktop/)
   - Linux: Install Docker Engine via your package manager

2. **Verify Installation**
   ```bash
   docker --version
   # Docker version 24.0.0, build xxxxx
   
   docker compose version
   # Docker Compose version v2.20.0
   ```

### Step-by-Step Guide

#### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd VizQL
```

#### Step 2: Start Everything
```bash
docker compose up
```

This command:
1. Downloads the `node:20-alpine` and `mysql:latest` images (first time only)
2. Builds the `vizql-app` image using the Dockerfile
3. Creates the `vizql-network` network
4. Starts the `vizql-db` container (MySQL)
5. Waits for MySQL to be ready (healthcheck)
6. Starts the `vizql-app` container (Nuxt)
7. Shows logs from both containers

#### Step 3: Wait for Ready Messages
Look for these in the logs:
```
vizql-db    | ready for connections
vizql-app   | Nuxt  ready in 2s
```

#### Step 4: Open the Application
Go to: **http://localhost:3000**

#### Step 5: Connect to Database
1. Click the **"Connect"** button
2. Use these credentials (pre-filled):
   - Host: `vizql-db`
   - Port: `3306`
   - Database: `vizql_db`
   - User: `vizql_user`
   - Password: `vizql_pass`

#### Step 6: Stop Everything
Press `Ctrl+C` in the terminal, then:
```bash
docker compose down
```

---

## 📝 Common Commands

### Starting and Stopping

| Command | What It Does |
|---------|--------------|
| `docker compose up` | Start all services (with logs) |
| `docker compose up -d` | Start in background (detached) |
| `docker compose down` | Stop and remove containers |
| `docker compose stop` | Stop containers (keep them) |
| `docker compose start` | Start stopped containers |
| `docker compose restart` | Restart all containers |

### Viewing Information

| Command | What It Does |
|---------|--------------|
| `docker compose ps` | List running containers |
| `docker compose logs` | View all logs |
| `docker compose logs vizql-app` | View app logs only |
| `docker compose logs -f` | Follow logs in real-time |

### Building and Rebuilding

| Command | What It Does |
|---------|--------------|
| `docker compose build` | Rebuild images |
| `docker compose up --build` | Start with fresh build |
| `docker compose build --no-cache` | Rebuild from scratch |

### Cleaning Up

| Command | What It Does |
|---------|--------------|
| `docker compose down -v` | Remove containers AND data |
| `docker system prune` | Clean unused resources |
| `docker volume prune` | Clean unused volumes |

### Accessing Containers

| Command | What It Does |
|---------|--------------|
| `docker exec -it vizql-app sh` | Shell into app container |
| `docker exec -it vizql-db mysql -u vizql_user -p vizql_db` | MySQL CLI |

---

## 🔧 Troubleshooting

### Problem: "Port 3000 already in use"

**Cause**: Another application is using port 3000

**Solutions**:
1. Stop the other application
2. Or change the port in `docker-compose.yml`:
   ```yaml
   ports:
     - "3001:3000"  # Use 3001 instead
   ```

### Problem: "Cannot connect to database"

**Cause**: Database isn't ready yet

**Solutions**:
1. Wait a bit longer (MySQL takes time to initialize)
2. Check logs: `docker compose logs vizql-db`
3. Ensure healthcheck passes: `docker compose ps`

### Problem: "Permission denied" on Linux

**Cause**: Docker requires root privileges

**Solution**:
```bash
sudo usermod -aG docker $USER
# Log out and log back in
```

### Problem: Changes not reflecting

**Cause**: Docker cached old files

**Solution**:
```bash
docker compose down
docker compose up --build
```

### Problem: Database is empty after restart

**Cause**: Volume was deleted

**Note**: If you used `docker compose down -v`, the database data was deleted. Just re-run sample-data.sql.

---

## 📖 Glossary

| Term | Definition |
|------|------------|
| **Container** | A running instance of an image; isolated environment for your app |
| **Image** | A template/blueprint used to create containers |
| **Dockerfile** | A text file with instructions to build an image |
| **Docker Compose** | Tool for running multi-container applications |
| **Volume** | Persistent storage that survives container restarts |
| **Network** | Virtual network allowing containers to communicate |
| **Port Mapping** | Connecting a port on your computer to a port in a container |
| **Build Context** | The directory Docker uses when building an image |
| **Multi-stage Build** | Building in stages to create smaller final images |
| **Healthcheck** | Automated check to verify a container is working |

---

## 🎓 Learning Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [Docker Compose Tutorial](https://docs.docker.com/compose/gettingstarted/)
- [Docker Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/)

---

## 📊 Quick Reference Card

```
┌──────────────────────────────────────────────────────┐
│                  VizQL Docker Setup                   │
├──────────────────────────────────────────────────────┤
│  Start:     docker compose up                        │
│  Stop:      docker compose down                      │
│  Rebuild:   docker compose up --build                │
│  Logs:      docker compose logs -f                   │
├──────────────────────────────────────────────────────┤
│  App URL:   http://localhost:3000                    │
│  DB Host:   vizql-db (inside Docker)                 │
│  DB Host:   localhost (from your computer)           │
│  DB Port:   3306                                     │
│  DB User:   vizql_user                               │
│  DB Pass:   vizql_pass                               │
└──────────────────────────────────────────────────────┘
```

---

*Happy containerizing! 🐳*
