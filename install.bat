@echo off
setlocal enabledelayedexpansion

echo.
echo ========================================
echo   🚀 SIMPLEVIM INSTALLER - WINDOWS
echo ========================================
echo.

set "NVIM_CONFIG=%LOCALAPPDATA%\nvim"

echo Checking Neovim installation...
nvim --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Neovim not found! Please install Neovim 0.9+ first.
    echo    Download from: https://neovim.io/
    pause
    exit /b 1
)

echo ✅ Neovim found!
echo.


echo 🧹 Cleaning previous Neovim installations...

:: Remove all Neovim config and data directories
if exist "%LOCALAPPDATA%\nvim" rmdir /s /q "%LOCALAPPDATA%\nvim" >nul 2>&1
if exist "%LOCALAPPDATA%\nvim-data" rmdir /s /q "%LOCALAPPDATA%\nvim-data" >nul 2>&1

echo 📦 Installing simplevim...

:: Create fresh directory
mkdir "%NVIM_CONFIG%" >nul 2>&1

:: Copy all files
xcopy /E /I /Y "init.lua" "%NVIM_CONFIG%\" >nul 2>&1
xcopy /E /I /Y "lua" "%NVIM_CONFIG%\lua\" >nul 2>&1

if errorlevel 1 (
    echo ❌ Installation failed!
    pause
    exit /b 1
)

echo ✅ Installation completed!
echo.
echo 🎉 SIMPLEVIM IS READY!
echo.
echo Next steps:
echo 1. Neovim will open automatically to install plugins
echo 2. Wait for plugins to install
echo 3. Restart Neovim when installation completes
echo 4. Install a Nerd Font for icons: https://nerdfonts.com
echo.
echo 🚀 Starting Neovim...
echo.
nvim