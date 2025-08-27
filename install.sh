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



echo
echo -e "${YELLOW}🧹 Cleaning previous Neovim installations...${NC}"

# Remove all Neovim config and data directories
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim  
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

# Remove Flatpak Neovim data (if exists)
rm -rf ~/.var/app/io.neovim.nvim/config/nvim 2>/dev/null
rm -rf ~/.var/app/io.neovim.nvim/data/nvim 2>/dev/null
rm -rf ~/.var/app/io.neovim.nvim/.local/state/nvim 2>/dev/null

echo -e "${GREEN}✅ Cleaned all Neovim directories${NC}"

echo -e "${BLUE}📦 Installing simplevim...${NC}"

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
echo -e "${YELLOW}1. Neovim will open automatically to install plugins${NC}"
echo -e "${YELLOW}2. Wait for plugins to install${NC}"
echo -e "${YELLOW}3. Restart Neovim when installation completes${NC}"
echo -e "${YELLOW}4. Install a Nerd Font for icons: https://nerdfonts.com${NC}"
echo
echo -e "${GREEN}🚀 Starting Neovim...${NC}"
echo
nvim