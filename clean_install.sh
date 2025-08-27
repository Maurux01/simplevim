#!/bin/bash

echo "========================================"
echo "    SIMPLEVIM CLEAN INSTALLER"
echo "========================================"
echo
echo "This will COMPLETELY REMOVE your current Neovim config"
echo "and install a fresh copy of simplevim."
echo
read -p "Are you sure? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo
echo "[1/4] Removing existing Neovim configuration..."
if [ -d "$HOME/.config/nvim" ]; then
    rm -rf "$HOME/.config/nvim"
    echo "- Removed config directory"
fi

echo
echo "[2/4] Removing Neovim data directory..."
if [ -d "$HOME/.local/share/nvim" ]; then
    rm -rf "$HOME/.local/share/nvim"
    echo "- Removed data directory"
fi

echo
echo "[3/4] Removing Neovim state directory..."
if [ -d "$HOME/.local/state/nvim" ]; then
    rm -rf "$HOME/.local/state/nvim"
    echo "- Removed state directory"
fi

echo
echo "[4/4] Installing fresh simplevim..."
cp -r "$(dirname "$0")" "$HOME/.config/nvim"
if [ $? -eq 0 ]; then
    echo "- Successfully copied simplevim configuration"
else
    echo "- Error copying files"
    exit 1
fi

echo
echo "========================================"
echo "    INSTALLATION COMPLETE!"
echo "========================================"
echo
echo "Next steps:"
echo "1. Open Neovim (nvim)"
echo "2. Wait for plugins to install automatically"
echo "3. Restart Neovim when installation is complete"
echo