# VizQL - Windows Setup Guide

This guide is specifically for Windows users running VizQL with PowerShell.

## Prerequisites Installation

### 1. Install Docker Desktop for Windows

**Download:**
https://www.docker.com/products/docker-desktop

**Installation Steps:**
1. Download Docker Desktop installer
2. Run installer (requires admin rights)
3. Follow installation wizard
4. Restart computer when prompted
5. Launch Docker Desktop
6. Wait for "Docker Desktop is running" message

**Verify Installation:**
```powershell
docker --version
docker-compose --version
```

Expected output:
```
Docker version 24.0.x
Docker Compose version v2.x.x
```

---

### 2. Install Git (Optional)

**Download:**
https://git-scm.com/download/win

**Or use Windows Package Manager:**
```powershell
winget install Git.Git
```

---

## Project Setup

### Navigate to Project Directory

```powershell
# Change directory to VizQL project
cd d:\Projects\VizQL

# Verify you're in the right place
Get-ChildItem
```

You should see:
```
docker-compose.yml
Dockerfile
README.md
app/
```

---

## Running VizQL

### First Run (Windows PowerShell)

```powershell
# Start Docker Desktop first (from Start menu)
# Wait for it to be ready

# Navigate to project
cd d:\Projects\VizQL

# Start application
docker-compose up
```

**What happens:**
- Downloads Node.js image (~100 MB)
- Downloads MySQL image (~600 MB)
- Installs dependencies (~250 MB)
- Builds application
- Starts development server

**Time:** 5-10 minutes first run

---

### Subsequent Runs

```powershell
# Much faster - only starts containers
docker-compose up
```

**Time:** 30-60 seconds

---

### Run in Background

```powershell
# Start and detach
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f vizql-app
```

---

### Stop Application

**Method 1: Ctrl+C**
- Press `Ctrl+C` in the terminal where docker-compose is running

**Method 2: Command**
```powershell
docker-compose down
```

**Method 3: Force Stop**
```powershell
docker-compose down --remove-orphans
```

---

## Windows-Specific Commands

### Check if Port is in Use

```powershell
# Check port 3000
netstat -ano | findstr :3000

# Check port 3306
netstat -ano | findstr :3306
```

### Kill Process on Port

```powershell
# Find PID from netstat output above
# Then kill it:
taskkill /PID <PID_NUMBER> /F

# Example:
taskkill /PID 12345 /F
```

---

### File Permissions

**Issue:** Docker can't access files

**Solution:**
```powershell
# Run PowerShell as Administrator
# Right-click PowerShell → "Run as Administrator"

# Then navigate and run:
cd d:\Projects\VizQL
docker-compose up
```

---

### Windows Firewall

**Issue:** Docker blocked by firewall

**Solution:**
1. Open Windows Defender Firewall
2. Click "Allow an app through firewall"
3. Find "Docker Desktop"
4. Check both "Private" and "Public"
5. Click OK

---

## Local Development (Without Docker)

### Install Node.js

**Download:**
https://nodejs.org/en/download

**Or use Windows Package Manager:**
```powershell
winget install OpenJS.NodeJS
```

**Verify:**
```powershell
node --version
npm --version
```

---

### Run Application Locally

```powershell
# Navigate to app directory
cd d:\Projects\VizQL\app

# Install dependencies
npm install

# Start development server
npm run dev
```

**Access:** http://localhost:3000

---

## Troubleshooting Windows Issues

### Docker Desktop Won't Start

**Check:**
1. Virtualization enabled in BIOS
2. Hyper-V enabled (Windows feature)
3. WSL 2 installed

**Enable Hyper-V:**
```powershell
# Run as Administrator
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

**Install WSL 2:**
```powershell
# Run as Administrator
wsl --install
```

---

### "Access Denied" Errors

**Solution 1: Run as Administrator**
- Right-click PowerShell
- Select "Run as Administrator"

**Solution 2: Add User to Docker Users Group**
1. Open Computer Management
2. Go to Local Users and Groups → Groups
3. Double-click "docker-users"
4. Add your user account
5. Log out and log back in

---

### Line Ending Issues

**Problem:** Git converts LF to CRLF

**Solution:**
```powershell
# Configure Git to not convert line endings
git config --global core.autocrlf false

# Re-clone repository
cd d:\Projects
Remove-Item -Recurse -Force VizQL
git clone <repo-url> VizQL
```

---

### Antivirus Interference

**Symptoms:**
- Slow npm install
- Files disappearing
- Permission errors

**Solution:**
Add these to antivirus exclusions:
- `d:\Projects\VizQL`
- `C:\Program Files\Docker`
- `%LOCALAPPDATA%\Docker`

---

### Memory Issues

**Docker uses too much RAM**

**Solution:**
1. Open Docker Desktop
2. Go to Settings (gear icon)
3. Resources → Advanced
4. Reduce memory limit to 4 GB
5. Click "Apply & Restart"

---

## PowerShell vs Command Prompt

### Recommended: PowerShell

**Why:**
- Better command support
- Modern features
- Native Docker support

**How to use:**
- Windows 11: Built-in
- Windows 10: Update from Microsoft Store

### Avoid: Command Prompt (cmd.exe)

Some commands work differently in cmd.exe.
Use PowerShell instead.

---

## Useful PowerShell Commands

### Directory Navigation
```powershell
# Change directory
cd d:\Projects\VizQL

# Go up one level
cd ..

# List files
Get-ChildItem
# or
ls

# Current directory
pwd
```

### Docker Commands
```powershell
# List running containers
docker ps

# List all containers
docker ps -a

# Stop all containers
docker stop $(docker ps -q)

# Remove all containers
docker rm $(docker ps -a -q)

# View images
docker images

# Remove unused data
docker system prune
```

### File Operations
```powershell
# Create file
New-Item -Path "test.txt" -ItemType File

# Delete file
Remove-Item "test.txt"

# Create directory
New-Item -Path "newfolder" -ItemType Directory

# Delete directory
Remove-Item -Recurse -Force "newfolder"

# Copy file
Copy-Item "source.txt" "dest.txt"

# View file contents
Get-Content "file.txt"
```

---

## Environment Variables

### View Environment Variables
```powershell
# List all
Get-ChildItem Env:

# View specific variable
$env:PATH
```

### Set Environment Variables
```powershell
# Temporary (current session)
$env:NODE_ENV = "development"

# Permanent (current user)
[System.Environment]::SetEnvironmentVariable("NODE_ENV", "development", "User")
```

---

## Performance Tips for Windows

### 1. Use WSL 2 Backend
Docker Desktop → Settings → General → "Use WSL 2 based engine"

### 2. Allocate Resources
Settings → Resources → Advanced:
- CPUs: 4
- Memory: 4 GB
- Swap: 1 GB

### 3. Keep Docker Updated
Settings → Updates → Check for updates

### 4. Restart Docker Desktop
Right-click Docker icon in system tray → Restart

---

## Windows Terminal (Recommended)

### Install Windows Terminal
```powershell
winget install Microsoft.WindowsTerminal
```

### Benefits
- Multiple tabs
- Split panes
- Better colors
- Customizable
- PowerShell, cmd, WSL in one app

### Open VizQL in Windows Terminal
1. Open Windows Terminal
2. New tab: PowerShell
3. Navigate: `cd d:\Projects\VizQL`
4. Run: `docker-compose up`

---

## VS Code Integration

### Install VS Code
```powershell
winget install Microsoft.VisualStudioCode
```

### Open Project in VS Code
```powershell
cd d:\Projects\VizQL
code .
```

### Recommended Extensions
- Docker
- Vue Language Features (Volar)
- Tailwind CSS IntelliSense
- TypeScript Vue Plugin (Volar)
- ESLint

---

## Keyboard Shortcuts

### PowerShell
- `Ctrl+C` - Stop current command
- `Ctrl+L` - Clear screen
- `Tab` - Auto-complete
- `↑` - Previous command
- `Ctrl+R` - Search command history

### Docker Compose
- `Ctrl+C` - Stop containers
- `Ctrl+Z` - Background process (use `docker-compose down` instead)

---

## Common Windows Paths

```powershell
# VizQL project
d:\Projects\VizQL

# Docker data
C:\ProgramData\Docker

# User Docker config
$env:USERPROFILE\.docker

# Temp files
$env:TEMP

# User profile
$env:USERPROFILE
```

---

## Checking System Requirements

### Check Windows Version
```powershell
winver
# Or:
[System.Environment]::OSVersion
```

Minimum: Windows 10 64-bit (Pro, Enterprise, or Education)

### Check Virtualization
```powershell
# Check if Hyper-V is enabled
Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V
```

### Check WSL
```powershell
wsl --status
```

### Check RAM
```powershell
Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
```

Recommended: 8 GB+ total, 4 GB for Docker

---

## Quick Reference Card

### Essential Commands
```powershell
# Start app
docker-compose up

# Start in background
docker-compose up -d

# Stop app
docker-compose down

# View logs
docker-compose logs -f

# Restart
docker-compose restart

# Rebuild
docker-compose up --build

# Clean restart
docker-compose down -v
docker-compose up --build

# Check status
docker-compose ps

# Access app
Start-Process http://localhost:3000
```

---

## Automation Scripts

### Create PowerShell Script: start-vizql.ps1

```powershell
# Save as: d:\Projects\VizQL\start-vizql.ps1

# Check if Docker is running
$dockerStatus = docker ps 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Starting Docker Desktop..." -ForegroundColor Yellow
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    Start-Sleep -Seconds 10
}

# Navigate to project
Set-Location d:\Projects\VizQL

# Start VizQL
Write-Host "Starting VizQL..." -ForegroundColor Green
docker-compose up
```

### Run Script
```powershell
# Allow script execution (once)
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Run script
.\start-vizql.ps1
```

---

## Create Desktop Shortcut

1. Right-click Desktop → New → Shortcut
2. Location:
   ```
   powershell.exe -NoExit -Command "cd d:\Projects\VizQL; docker-compose up"
   ```
3. Name: "VizQL"
4. Click Finish

**Double-click shortcut to start VizQL!**

---

## Windows-Specific FAQs

### Q: Can I use Windows Home edition?
A: Docker Desktop requires Pro/Enterprise/Education for Hyper-V. 
   Alternative: Use Docker Toolbox or upgrade to Pro.

### Q: WSL vs Hyper-V?
A: Use WSL 2 (modern, faster). Hyper-V is legacy.

### Q: Can I use Git Bash?
A: Yes, but PowerShell is recommended for better compatibility.

### Q: Drive letter in paths?
A: Yes, Windows uses `C:\` or `D:\`. Linux uses `/c/` or `/d/`.

### Q: File permissions error?
A: Run PowerShell as Administrator or add user to docker-users group.

---

## Getting Help

### Windows-Specific Issues
Check: [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

### Docker Desktop Issues
https://docs.docker.com/desktop/troubleshoot/overview/

### PowerShell Help
```powershell
Get-Help <command>
# Example:
Get-Help docker
```

---

**You're all set! Start VizQL on Windows! 🚀**

```powershell
cd d:\Projects\VizQL
docker-compose up
```

**Access:** http://localhost:3000

---

*Part of VizQL Phase 1 Documentation*
