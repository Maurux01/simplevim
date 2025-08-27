@echo off
setlocal enabledelayedexpansion

echo.
echo ========================================
echo   🚀 SIMPLEVIM INSTALLER - WINDOWS
echo ========================================
echo.

set "NVIM_CONFIG=%LOCALAPPDATA%\nvim"
set "BACKUP_DIR=%LOCALAPPDATA%\nvim.backup.%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "BACKUP_DIR=%BACKUP_DIR: =0%"

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

if exist "%NVIM_CONFIG%" (
    echo 📁 Existing config found at: %NVIM_CONFIG%
    echo 💾 Creating backup at: %BACKUP_DIR%
    move "%NVIM_CONFIG%" "%BACKUP_DIR%" >nul 2>&1
    if errorlevel 1 (
        echo ❌ Failed to backup existing config
        pause
        exit /b 1
    )
    echo ✅ Backup created successfully!
)

echo.
echo 📦 Installing simplevim...

:: Remove any existing config completely
if exist "%NVIM_CONFIG%" (
    rmdir /s /q "%NVIM_CONFIG%" >nul 2>&1
)

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
echo 1. Open Neovim: nvim
echo 2. Wait for plugins to install automatically
echo 3. Restart Neovim
echo 4. Install a Nerd Font for icons: https://nerdfonts.com
echo.
echo Enjoy your new Neovim setup! 🚀
echo.
pause