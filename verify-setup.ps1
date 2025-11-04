# VizQL Setup Verification Script
# Run this to check if your environment is ready

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VizQL Setup Verification" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$allGood = $true

# Check 1: Docker
Write-Host "Checking Docker..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Docker installed: $dockerVersion" -ForegroundColor Green
    } else {
        Write-Host "✗ Docker not found" -ForegroundColor Red
        Write-Host "  Install from: https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
        $allGood = $false
    }
} catch {
    Write-Host "✗ Docker not found" -ForegroundColor Red
    $allGood = $false
}

# Check 2: Docker Compose
Write-Host "`nChecking Docker Compose..." -ForegroundColor Yellow
try {
    $composeVersion = docker-compose --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Docker Compose installed: $composeVersion" -ForegroundColor Green
    } else {
        Write-Host "✗ Docker Compose not found" -ForegroundColor Red
        $allGood = $false
    }
} catch {
    Write-Host "✗ Docker Compose not found" -ForegroundColor Red
    $allGood = $false
}

# Check 3: Docker Running
Write-Host "`nChecking if Docker is running..." -ForegroundColor Yellow
try {
    $dockerPs = docker ps 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Docker is running" -ForegroundColor Green
    } else {
        Write-Host "✗ Docker is not running" -ForegroundColor Red
        Write-Host "  Start Docker Desktop from Start menu" -ForegroundColor Yellow
        $allGood = $false
    }
} catch {
    Write-Host "✗ Docker is not running" -ForegroundColor Red
    $allGood = $false
}

# Check 4: Port 3000 availability
Write-Host "`nChecking port 3000..." -ForegroundColor Yellow
$port3000 = netstat -ano | findstr :3000
if ($port3000) {
    Write-Host "✗ Port 3000 is in use" -ForegroundColor Red
    Write-Host "  You may need to stop other services or change VizQL port" -ForegroundColor Yellow
    Write-Host "  Current usage: $port3000" -ForegroundColor Gray
    $allGood = $false
} else {
    Write-Host "✓ Port 3000 is available" -ForegroundColor Green
}

# Check 5: Port 3306 availability
Write-Host "`nChecking port 3306..." -ForegroundColor Yellow
$port3306 = netstat -ano | findstr :3306
if ($port3306) {
    Write-Host "⚠ Port 3306 is in use (MySQL)" -ForegroundColor Yellow
    Write-Host "  This is OK if you have local MySQL. Docker will handle it." -ForegroundColor Gray
    Write-Host "  Or you can change the port in docker-compose.yml" -ForegroundColor Gray
} else {
    Write-Host "✓ Port 3306 is available" -ForegroundColor Green
}

# Check 6: Project files
Write-Host "`nChecking project files..." -ForegroundColor Yellow
$requiredFiles = @(
    "docker-compose.yml",
    "Dockerfile",
    "app\package.json",
    "app\nuxt.config.ts"
)

$missingFiles = @()
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "✓ Found: $file" -ForegroundColor Green
    } else {
        Write-Host "✗ Missing: $file" -ForegroundColor Red
        $missingFiles += $file
        $allGood = $false
    }
}

# Check 7: Disk space
Write-Host "`nChecking disk space..." -ForegroundColor Yellow
$drive = (Get-Location).Drive
$freeSpace = (Get-PSDrive $drive.Name).Free / 1GB
if ($freeSpace -gt 5) {
    Write-Host "✓ Free space: $([math]::Round($freeSpace, 2)) GB available" -ForegroundColor Green
} else {
    Write-Host "⚠ Low disk space: $([math]::Round($freeSpace, 2)) GB" -ForegroundColor Yellow
    Write-Host "  VizQL needs ~5 GB for Docker images and dependencies" -ForegroundColor Gray
}

# Check 8: Memory
Write-Host "`nChecking system memory..." -ForegroundColor Yellow
$totalRAM = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB
if ($totalRAM -gt 8) {
    Write-Host "✓ Total RAM: $([math]::Round($totalRAM, 2)) GB" -ForegroundColor Green
} else {
    Write-Host "⚠ RAM: $([math]::Round($totalRAM, 2)) GB" -ForegroundColor Yellow
    Write-Host "  Recommended: 8 GB or more for smooth operation" -ForegroundColor Gray
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
if ($allGood) {
    Write-Host "✓ All checks passed!" -ForegroundColor Green
    Write-Host "`nYou're ready to start VizQL!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "  1. Run: docker-compose up" -ForegroundColor White
    Write-Host "  2. Wait for 'Nuxt is ready' message" -ForegroundColor White
    Write-Host "  3. Open: http://localhost:3000" -ForegroundColor White
    Write-Host "`nFor detailed instructions, see QUICKSTART.md" -ForegroundColor Gray
} else {
    Write-Host "✗ Some checks failed" -ForegroundColor Red
    Write-Host "`nPlease fix the issues above before starting VizQL." -ForegroundColor Yellow
    Write-Host "`nFor help, see:" -ForegroundColor Cyan
    Write-Host "  - WINDOWS_SETUP.md (Windows-specific guide)" -ForegroundColor White
    Write-Host "  - TROUBLESHOOTING.md (Common issues)" -ForegroundColor White
    Write-Host "  - QUICKSTART.md (Setup instructions)" -ForegroundColor White
}
Write-Host "========================================`n" -ForegroundColor Cyan

# Optional: Node.js check (for local development)
Write-Host "`nOptional: Node.js (for local development without Docker)" -ForegroundColor Cyan
try {
    $nodeVersion = node --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Node.js installed: $nodeVersion" -ForegroundColor Green
    } else {
        Write-Host "○ Node.js not installed (not required for Docker setup)" -ForegroundColor Gray
    }
} catch {
    Write-Host "○ Node.js not installed (not required for Docker setup)" -ForegroundColor Gray
}

try {
    $npmVersion = npm --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ npm installed: v$npmVersion" -ForegroundColor Green
    }
} catch {
    # Silently skip
}

Write-Host ""
