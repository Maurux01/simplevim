# 🚀 simplevim
**fast simple cute nvim** - Minimal, modern and functional Neovim configuration
![alt text](image.png)
## ✨ Features

- ⚡ **Ultra fast**: Loads in < 0.3 seconds
- 🎨 **Beautiful**: Tokyo Night theme with modern UI
- 🧠 **Smart**: LSP, autocompletion, auto-formatting
- 📁 **Functional**: File explorer, search, git integration
- 🔧 **Minimal**: Only essentials, no bloat

## 📦 Included plugins

- **Plugin Manager**: `lazy.nvim` (fastest)
- **Themes**: 6 dark themes (Tokyo Night, Catppuccin, Gruvbox, Kanagawa, Dracula, OneDark)
- **LSP**: `mason.nvim` + `lspconfig` (Lua, Python, TypeScript)
- **Autocompletion**: `nvim-cmp` + `LuaSnip` + `friendly-snippets`
- **Explorer**: `neo-tree.nvim` (with icons)
- **Search**: `telescope.nvim` (files and text)
- **UI**: `lualine.nvim` + `bufferline.nvim` + `alpha-nvim`
- **Git**: `gitsigns.nvim` (changes in gutter)
- **Formatting**: `conform.nvim` (auto on save)
- **Syntax**: `nvim-treesitter` (advanced highlighting)
- **Editing**: Auto-pairs, surround, comments
- **Snippets**: LuaSnip with custom snippets
- **Animations**: Animated cursor, smooth scroll, indent guides
- **Which-key**: Visual guide for keybindings
- **Whitespace**: Visualization of spaces and tabs

## 🚀 Installation

### 1. Requirements
- Neovim 0.9+
- Git
- Node.js (for TypeScript LSP)
- Python (for Python LSP)

### 2. Automatic installation

**Option 1: Automatic installer (Recommended)**

```bash
# Clone the repository
git clone https://github.com/Maurux01/simplevim.git
cd simplevim

# Windows
install.bat

# Linux/macOS
chmod +x install.sh
./install.sh
```

**Option 2: Manual installation**

**Windows:**
```cmd
# Backup existing config (optional)
ren %LOCALAPPDATA%\nvim %LOCALAPPDATA%\nvim.backup

# Clone simplevim
git clone https://github.com/Maurux01/simplevim.git %LOCALAPPDATA%\nvim
```

**Linux/macOS:**
```bash
# Backup existing config (optional)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone simplevim
git clone https://github.com/Maurux01/simplevim.git ~/.config/nvim
```

### 3. First run

```bash
nvim
```

All plugins will be installed automatically on first run. Wait for it to finish and restart Neovim.

## ⌨️ Main keybindings

### General
- `<Space>` - Leader key (shows which-key after 300ms)
- `<Ctrl-s>` - Save file
- `<Esc>` - Clear search

### Navigation
- `<Ctrl-h/j/k/l>` - Move between windows
- `<Shift-h/l>` - Switch between buffers
- `<Ctrl-Shift-j/k>` - Move lines up/down

### File explorer
- `<Space>e` - Open/close Neo-tree

### Search (Telescope)
- `<Space>ff` - Find files
- `<Space>fg` - Find text
- `<Space>fb` - Find buffers
- `<Space>fr` - Recent files

### LSP
- `gd` - Go to definition
- `K` - Show documentation
- `<Space>rn` - Rename
- `<Space>ca` - Code actions
- `<Space>f` - Format code

### Git
- `]h` / `[h` - Next/previous change
- `<Space>ghs` - Stage hunk
- `<Space>ghr` - Reset hunk
- `<Space>ghp` - Preview hunk

### Buffers
- `<Space>bd` - Close buffer
- `<Space>bo` - Close other buffers
- `<Space>ba` - Close all buffers
- `<Space>bp` - Pin/unpin buffer

### Window Control
**Navigation:**
- `<Ctrl-h/j/k/l>` - Move between windows
- `<Alt-h/j/k/l>` - Alternative navigation

**Create/Close:**
- `<Space>wv` - Vertical split
- `<Space>wh` - Horizontal split
- `<Space>wx` - Close current window
- `<Space>wo` - Close other windows
- `<Space>wm` - Maximize/restore window

**Resize:**
- `<Shift-Arrows>` - Fast resize (±5)
- `<Ctrl-Arrows>` - Slow resize (±2)
- `<Space>w+/-` - Height ±10
- `<Space>w</>` - Width ±10
- `<Space>we` - Equal sizes

**Move windows:**
- `<Space>wH/J/K/L` - Move window left/down/up/right

**Compatibility (legacy):**
- `<Space>sv/sh/se/sx` - Classic splits

### Terminal
- `<Space>th` - Horizontal terminal
- `<Space>tv` - Vertical terminal
- `<Space>tt` - Terminal in new tab
- `<Esc>` - Exit terminal mode (in terminal)
- `<Ctrl-h/j/k/l>` - Navigate from terminal

### Tabs
- `<Space>to` - New tab
- `<Space>tx` - Close tab
- `<Space>tn` - Next tab
- `<Space>tp` - Previous tab

### Visualization
- Spaces shown as dots (·)
- Tabs shown as double dots (::)
- Cursor with colorful tail animation
- Smooth scroll with animations
- Animated indent guides

### Themes
- `<Space>ct` - Change theme (cycle through all)
- `:Theme tokyo` - Tokyo Night
- `:Theme cat` - Catppuccin Mocha
- `:Theme gruvbox` - Gruvbox Hard
- `:Theme kanagawa` - Kanagawa Wave
- `:Theme dracula` - Dracula
- `:Theme onedark` - One Dark

## 🎨 Customization

The configuration is organized in modules:

```
lua/
├── config/
│   ├── options.lua    # Neovim options + whitespace
│   ├── keymaps.lua    # Keybindings + which-key
│   └── lazy.lua       # lazy.nvim configuration
└── plugins/
    ├── animations.lua # Cursor, scroll, which-key, indent
    ├── colorscheme.lua # Theme
    ├── lsp.lua        # Language Server Protocol
    ├── cmp.lua        # Autocompletion
    ├── telescope.lua  # Search
    ├── neo-tree.lua   # Explorer
    ├── ui.lua         # Interface + cursor colors
    ├── git.lua        # Git integration
    ├── formatting.lua # Auto formatting
    ├── treesitter.lua # Syntax highlighting
    ├── snippets.lua   # Custom snippets
    └── editor.lua     # Editing tools
```

### Change theme
**Option 1: Quick command**
```vim
:Theme cat        " Catppuccin
:Theme gruvbox    " Gruvbox
:Theme kanagawa   " Kanagawa
:Theme dracula    " Dracula
:Theme onedark    " One Dark
:Theme tokyo      " Tokyo Night (default)
```

**Option 2: Keyboard shortcut**
- `<Space>ct` - Cycle through all themes

**Option 3: Change default theme**
Edit `lua/plugins/colorscheme.lua` and change the line:
```lua
vim.cmd([[colorscheme tokyonight]])
```

### Add LSP for other languages
Edit `lua/plugins/lsp.lua` and add the server to `ensure_installed`.

## 🔧 Useful commands

- `:Lazy` - Manage plugins
- `:Mason` - Install LSP servers
- `:checkhealth` - Check configuration
- `:ConformInfo` - Formatter info

## 🐛 Troubleshooting

### Icons don't look right
Install a Nerd Font: https://www.nerdfonts.com/

### LSP doesn't work
```vim
:Mason
```
Install the corresponding server (lua_ls, pyright, tsserver, etc.)

### Auto formatting doesn't work
Verify you have the formatters installed:
```bash
npm install -g prettier  # For JS/TS/JSON/HTML/CSS
pip install black isort  # For Python
```

## 📄 License

MIT License - Use it however you want 🎉