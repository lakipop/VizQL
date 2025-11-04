# VizQL - Troubleshooting Guide

This guide helps you resolve common issues when setting up and running VizQL.

## Table of Contents

1. [Docker Issues](#docker-issues)
2. [Port Conflicts](#port-conflicts)
3. [Installation Problems](#installation-problems)
4. [Build Errors](#build-errors)
5. [Runtime Issues](#runtime-issues)
6. [TypeScript Errors](#typescript-errors)
7. [Styling Problems](#styling-problems)
8. [Database Issues](#database-issues)

---

## Docker Issues

### Docker Desktop Not Running

**Symptom:**
```
Cannot connect to the Docker daemon
```

**Solution:**
- Start Docker Desktop
- Wait for it to fully initialize
- Check system tray for Docker icon (should be running, not starting)

---

### Containers Won't Start

**Symptom:**
```
Error response from daemon: driver failed
```

**Solution 1: Clean restart**
```powershell
docker-compose down -v
docker-compose up --build
```

**Solution 2: Remove all containers and images**
```powershell
docker-compose down -v
docker system prune -a
docker-compose up --build
```

---

### Slow First Build

**Symptom:**
Docker build takes 5-10 minutes on first run

**This is normal!**
- Downloading Node.js image (~100MB)
- Downloading MySQL image (~600MB)
- Installing npm packages (~250MB)
- Subsequent runs are much faster (30 seconds)

**Tip:** Run `docker-compose up -d` to run in background

---

### Container Exits Immediately

**Symptom:**
```
vizql-app exited with code 1
```

**Solution:**
Check logs for error details:
```powershell
docker-compose logs vizql-app
```

Common causes:
- Missing dependencies (rebuild: `docker-compose up --build`)
- Syntax errors in code (check logs)
- Port already in use (see Port Conflicts section)

---

## Port Conflicts

### Port 3000 Already in Use

**Symptom:**
```
Error: bind: address already in use
```

**Solution 1: Find what's using port 3000**
```powershell
netstat -ano | findstr :3000
```

Kill the process:
```powershell
taskkill /PID <PID> /F
```

**Solution 2: Change VizQL port**
Edit `docker-compose.yml`:
```yaml
services:
  vizql-app:
    ports:
      - "3001:3000"  # Change 3001 to any free port
```

Then access at http://localhost:3001

---

### Port 3306 Already in Use (MySQL)

**Symptom:**
```
vizql-db: bind: address already in use
```

**Solution 1: Stop local MySQL**
```powershell
net stop mysql
```

**Solution 2: Change MySQL port**
Edit `docker-compose.yml`:
```yaml
services:
  vizql-db:
    ports:
      - "3307:3306"  # Change 3307 to any free port
```

Update connection settings in Phase 2 accordingly.

---

## Installation Problems

### npm install Fails

**Symptom:**
```
npm ERR! code ERESOLVE
npm ERR! ERESOLVE could not resolve
```

**Solution 1: Clear cache and retry**
```powershell
cd app
npm cache clean --force
Remove-Item -Recurse -Force node_modules
Remove-Item -Force package-lock.json
npm install
```

**Solution 2: Use legacy peer deps**
```powershell
npm install --legacy-peer-deps
```

---

### Permission Errors on Windows

**Symptom:**
```
Error: EPERM: operation not permitted
```

**Solution:**
- Run PowerShell as Administrator
- Or disable antivirus temporarily during install
- Or add project folder to antivirus exclusions

---

## Build Errors

### Nuxt Build Fails

**Symptom:**
```
ERROR: Cannot start nuxt
```

**Solution 1: Clear Nuxt cache**
```powershell
cd app
Remove-Item -Recurse -Force .nuxt
Remove-Item -Recurse -Force .output
npm run dev
```

**Solution 2: Reinstall dependencies**
```powershell
Remove-Item -Recurse -Force node_modules
npm install
npm run dev
```

---

### Tailwind CSS Not Working

**Symptom:**
Styles not applying, everything looks unstyled

**Solution:**
Check `nuxt.config.ts` includes:
```typescript
modules: [
  '@nuxtjs/tailwindcss'
]
```

And `tailwind.config.ts` has correct content paths:
```typescript
content: [
  './components/**/*.{js,vue,ts}',
  './pages/**/*.vue',
  './app.vue',
]
```

Restart dev server:
```powershell
# Stop with Ctrl+C, then:
npm run dev
```

---

## Runtime Issues

### Blank White Screen

**Symptom:**
Application loads but shows blank white screen

**Solution:**
1. Open browser DevTools (F12)
2. Check Console tab for errors
3. Common causes:
   - Component import error
   - Missing props
   - JavaScript error

Fix the error and refresh.

---

### Hot Reload Not Working

**Symptom:**
Changes to code don't reflect in browser

**Solution 1: Hard refresh**
- Press Ctrl+Shift+R (Windows)
- Or Cmd+Shift+R (Mac)

**Solution 2: Restart dev server**
```powershell
# Stop with Ctrl+C
docker-compose restart vizql-app
```

**Solution 3: Clear browser cache**
- Open DevTools (F12)
- Right-click refresh button
- Select "Empty Cache and Hard Reload"

---

### "Cannot find module" Error

**Symptom:**
```
Cannot find module 'vue' or its corresponding type declarations
```

**This is expected before npm install!**

**Solution:**
If using Docker, this is normal - dependencies are in container.

If running locally:
```powershell
cd app
npm install
```

TypeScript errors in IDE will disappear after install.

---

## TypeScript Errors

### Red Squiggles in VS Code

**Symptom:**
TypeScript errors in editor before running app

**This is normal!**
- Dependencies not installed yet
- Or IDE needs to reload

**Solution:**
1. Install dependencies: `npm install`
2. Reload VS Code: Ctrl+Shift+P → "Reload Window"
3. Wait for TypeScript server to initialize (bottom bar)

---

### Type Errors Don't Match Runtime

**Symptom:**
App works but TypeScript shows errors

**Solution:**
Restart TypeScript server:
- Ctrl+Shift+P
- Type "TypeScript: Restart TS Server"
- Press Enter

---

## Styling Problems

### Components Look Too Big/Spaced

**Symptom:**
Layout doesn't feel compact

**Check:**
- Are you using `text-sm` or `text-xs`?
- Are you using `p-2` or `p-3` (not `p-4` or higher)?
- Are borders `border` not `border-2` or `border-4`?

**Fix:**
Use smaller utilities:
```vue
<!-- Too spacious -->
<div class="p-8 text-lg">

<!-- Correct for VizQL -->
<div class="p-2 text-xs">
```

---

### Colors Look Too Bright

**Symptom:**
UI looks too vibrant, not matte

**Check:**
Are you using VizQL theme colors?
- `bg-gray-900` not `bg-gray-500`
- `text-gray-300` not `text-white`
- `text-yellow-400` not `text-yellow-200`

**Fix:**
Use desaturated colors from `tailwind.config.ts`.

---

## Database Issues

### Can't Connect to Database (Phase 2)

**Symptom:**
```
ECONNREFUSED 127.0.0.1:3306
```

**Solution:**
Check Docker container is running:
```powershell
docker ps
```

Should show `vizql-db` with status "Up".

If not running:
```powershell
docker-compose up vizql-db
```

---

### MySQL Container Keeps Restarting

**Symptom:**
```
vizql-db is restarting
```

**Solution:**
Check MySQL logs:
```powershell
docker-compose logs vizql-db
```

Common causes:
- Insufficient memory (allocate more to Docker)
- Corrupted volume (remove: `docker-compose down -v`)

---

## Performance Issues

### Slow Application Load Time

**Symptom:**
App takes 10+ seconds to load

**Solutions:**

1. **First load is always slower** (10-15 sec)
   - Subsequent loads: 1-2 sec

2. **Clear browser cache**
   - DevTools → Application → Clear storage

3. **Optimize Docker resources**
   - Docker Desktop → Settings → Resources
   - Increase CPU: 4 cores
   - Increase Memory: 4 GB

---

### High Memory Usage

**Symptom:**
Docker using 2+ GB of RAM

**This is normal for development!**
- Node.js dev server: ~500 MB
- MySQL: ~500 MB
- Docker overhead: ~500 MB

**Reduce usage:**
- Stop when not developing: `docker-compose down`
- Use production build: smaller, faster

---

## Browser Issues

### Chart Not Rendering

**Symptom:**
Table view works, but chart view shows blank

**Solution:**
Check browser console (F12) for errors.

Common causes:
- Chart.js not loaded (check network tab)
- Data format incorrect (should be array of objects)

Refresh page to reload Chart.js.

---

### Layout Broken on Safari

**Symptom:**
Grid layout doesn't work properly

**Note:** Phase 1 tested on Chrome, Edge, Firefox.
Safari compatibility in Phase 2.

**Workaround:**
Use Chrome or Edge for development.

---

## General Debugging Steps

### When Something Doesn't Work

1. **Check Console Logs**
   ```powershell
   # Docker logs
   docker-compose logs -f vizql-app
   
   # Browser console (F12)
   ```

2. **Restart Everything**
   ```powershell
   docker-compose down
   docker-compose up
   ```

3. **Clean Build**
   ```powershell
   docker-compose down -v
   docker-compose build --no-cache
   docker-compose up
   ```

4. **Check File Changes**
   ```powershell
   git status
   git diff
   ```

5. **Verify Environment**
   ```powershell
   docker --version
   node --version  # If running locally
   npm --version   # If running locally
   ```

---

## Getting More Help

### Useful Commands

**Docker Status:**
```powershell
docker ps                      # Running containers
docker-compose ps              # Project containers
docker stats                   # Resource usage
```

**Docker Cleanup:**
```powershell
docker-compose down            # Stop containers
docker-compose down -v         # Stop + remove volumes
docker system prune            # Remove unused data
docker system prune -a         # Remove all unused data
```

**Logs:**
```powershell
docker-compose logs            # All logs
docker-compose logs vizql-app  # App logs only
docker-compose logs -f         # Follow (live)
docker-compose logs --tail=50  # Last 50 lines
```

---

### VS Code Issues

**Extensions Recommended:**
- Vue Language Features (Volar)
- TypeScript Vue Plugin (Volar)
- Tailwind CSS IntelliSense
- ESLint
- Docker

**Settings:**
- Enable "Format on Save"
- Set default formatter to Volar
- Enable TypeScript validation

---

### Still Having Issues?

1. **Check documentation:**
   - README.md
   - QUICKSTART.md
   - DEVELOPMENT.md

2. **Check package versions:**
   ```powershell
   cd app
   npm list
   ```

3. **Try local development** (without Docker):
   ```powershell
   cd app
   npm install
   npm run dev
   ```

4. **Create fresh clone:**
   ```powershell
   cd ..
   git clone <repo> VizQL-fresh
   cd VizQL-fresh
   docker-compose up
   ```

---

## Common Error Messages

### "Module not found: Can't resolve"

**Cause:** Missing dependency or wrong import path

**Fix:**
```powershell
cd app
npm install <missing-package>
```

---

### "ERR_PNPM_NO_MATCHING_VERSION"

**Cause:** Using pnpm instead of npm

**Fix:**
Use npm exclusively:
```powershell
npm install
npm run dev
```

---

### "ENOSPC: System limit for number of file watchers"

**Cause:** Linux file watcher limit (WSL2)

**Fix:**
```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

---

### "Port is already allocated"

**Cause:** Container using port didn't stop cleanly

**Fix:**
```powershell
docker-compose down
docker ps -a
docker rm -f <container-id>
docker-compose up
```

---

## Prevention Tips

### Best Practices

1. **Always use docker-compose down** before system shutdown
2. **Don't edit files inside containers** (use volumes)
3. **Commit working code frequently** (easy to revert)
4. **Keep Docker Desktop updated**
5. **Don't modify node_modules manually**
6. **Use .gitignore** (already configured)

### Health Checks

**Before starting work:**
```powershell
# Check Docker is running
docker ps

# Check ports are free
netstat -ano | findstr :3000
netstat -ano | findstr :3306

# Check disk space
docker system df
```

**After coding session:**
```powershell
# Stop containers
docker-compose down

# Check for errors
docker-compose logs --tail=20
```

---

**Still stuck?** Check the official docs:
- Nuxt 3: https://nuxt.com/docs
- Docker: https://docs.docker.com
- Vue 3: https://vuejs.org/guide

---

Happy debugging! 🔧
