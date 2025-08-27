#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
echo "========================================"
echo "   🚀 SIMPLEVIM INSTALLER - LINUX/MAC"
echo "========================================"
echo -e "${NC}"

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}❌ Neovim not found! Please install Neovim 0.9+ first.${NC}"
    echo -e "${YELLOW}   Ubuntu/Debian: sudo apt install neovim${NC}"
    echo -e "${YELLOW}   Arch: sudo pacman -S neovim${NC}"
    echo -e "${YELLOW}   macOS: brew install neovim${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Neovim found!${NC}"
echo

# Set config directory
if [[ "$OSTYPE" == "darwin"* ]]; then
    NVIM_CONFIG="$HOME/.config/nvim"
else
    NVIM_CONFIG="$HOME/.config/nvim"
fi

BACKUP_DIR="${NVIM_CONFIG}.backup.$(date +%Y%m%d_%H%M%S)"

# Backup existing config
if [ -d "$NVIM_CONFIG" ]; then
    echo -e "${YELLOW}📁 Existing config found at: $NVIM_CONFIG${NC}"
    echo -e "${BLUE}💾 Creating backup at: $BACKUP_DIR${NC}"
    
    if mv "$NVIM_CONFIG" "$BACKUP_DIR"; then
        echo -e "${GREEN}✅ Backup created successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to backup existing config${NC}"
        exit 1
    fi
fi

echo
echo -e "${BLUE}📦 Installing simplevim...${NC}"

# Remove any existing config completely
if [ -d "$NVIM_CONFIG" ]; then
    rm -rf "$NVIM_CONFIG"
fi

# Create fresh config directory
mkdir -p "$NVIM_CONFIG"

# Copy files
if cp -r init.lua lua "$NVIM_CONFIG/"; then
    echo -e "${GREEN}✅ Installation completed!${NC}"
else
    echo -e "${RED}❌ Installation failed!${NC}"
    exit 1
fi

echo
echo -e "${PURPLE}🎉 SIMPLEVIM IS READY!${NC}"
echo
echo -e "${CYAN}Next steps:${NC}"
echo -e "${YELLOW}1. Open Neovim: nvim${NC}"
echo -e "${YELLOW}2. Wait for plugins to install automatically${NC}"
echo -e "${YELLOW}3. Restart Neovim${NC}"
echo -e "${YELLOW}4. Install a Nerd Font for icons: https://nerdfonts.com${NC}"
echo
echo -e "${GREEN}Enjoy your new Neovim setup! 🚀${NC}"
echo