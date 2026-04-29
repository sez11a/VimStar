# Powershell script for installing VimStar on Windows

Write-Host "This script installs VimStar, a Neovim distribution with a writing and programming focus." -ForegroundColor Green
Write-Host "Beginning install..." -ForegroundColor Green

$VimStarDir = Join-Path $env:USERPROFILE ".VimStar"
$NeovimConfigDir = Join-Path $env:LOCALAPPDATA "nvim"

# Clone or update VimStar
if (-not (Test-Path $VimStarDir)) {
    Write-Host "Cloning VimStar from GitHub into $VimStarDir..." -ForegroundColor Yellow
    git clone "https://github.com/sez11a/VimStar" $VimStarDir
} else {
    Write-Host "Updating VimStar from GitHub..." -ForegroundColor Yellow
    Set-Location (Join-Path $VimStarDir "..")
    git -C $VimStarDir pull
}

# Ensure Neovim config directory exists
Write-Host "Creating Neovim config directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path $NeovimConfigDir -Force | Out-Null

# Copy VimStar to Neovim config directory
Write-Host "Copying VimStar configuration to $NeovimConfigDir..." -ForegroundColor Yellow
Copy-Item -Path (Join-Path $VimStarDir "*") -Destination $NeovimConfigDir -Recurse -Force

# Ensure spell directory exists
Write-Host "Creating spell directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path (Join-Path $VimStarDir "spell") -Force | Out-Null

# Copy user template if not exists
$UserConfig = Join-Path $VimStarDir "lua" "vimstar-user.lua"
if (-not (Test-Path $UserConfig)) {
    Write-Host "Copying default config to $UserConfig..." -ForegroundColor Yellow
    Copy-Item -Path (Join-Path $VimStarDir "vimstar-user-template") -Destination $UserConfig
}

Write-Host "Install finished! Run Neovim to finish setup!" -ForegroundColor Green
