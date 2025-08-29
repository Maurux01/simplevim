# 🚀 simplevim
**fast, simple, and elegant nvim** - Minimal, modern and functional Neovim configuration
![alt text](pics/image.png)
## ✨ Features

This configuration is packed with features to make your Neovim experience as smooth as possible.

- **Plugin Manager**: Fast plugin management with `lazy.nvim`.
- **Modern UI**: A beautiful and functional UI with `tokyo-night` theme, `lualine.nvim`, `bufferline.nvim`, and `alpha-nvim`.
- **Smart Editing**:
    - Autocompletion with `nvim-cmp` and `LuaSnip`.
    - Advanced syntax highlighting with `nvim-treesitter`.
    - Auto-formatting on save with `conform.nvim`.
    - Auto-pairs, surround, and comments with various plugins.
- **LSP**: Full LSP support with `mason.nvim` and `lspconfig`.
- **File Explorer**: A modern file explorer with `neo-tree.nvim`.
- **Search**: Fast and powerful search with `telescope.nvim`.
- **Git Integration**: Git integration with `gitsigns.nvim`.
- **Animations**: Smooth animations for a better user experience.
- **Which-key**: A handy keybinding guide with `which-key.nvim`.
- **Command Line**: Smart command line suggestions with `cmp-cmdline`.

## 🚀 Installation

### 0. Clean previous installations (if needed)

If you have issues with corrupted plugins or configurations, clean everything first:

**Linux / MacOS (unix):**
```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

**Flatpak (linux):**
```bash
rm -rf ~/.var/app/io.neovim.nvim/config/nvim
rm -rf ~/.var/app/io.neovim.nvim/data/nvim
rm -rf ~/.var/app/io.neovim.nvim/.local/state/nvim
```

**Windows CMD:**
```
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data
```

**Windows PowerShell:**
```powershell
rm -Force ~\AppData\Local\nvim
rm -Force ~\AppData\Local\nvim-data
```

### NixOS

For NixOS installation instructions, please see [NIX.md](./NIX.md).

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



### 3. First run

```bash
nvim
```

All plugins will be installed automatically on first run. Wait for it to finish and restart Neovim.

## ⌨️ Main keybindings

The leader key is set to the space bar.

### General
- `<Space>` - Leader key (shows which-key after 300ms)
- `<Ctrl-s>` - Save file
- `<leader>ch` - Clear search highlighting

### File Operations
- `<Space>w` - Save file
- `<Space>wn` - New file
- `<Space>wd` - Delete current file
- `<Space>wm` - Create directory

### Quit Operations
- `<Space>q` - Quit
- `<Space>q!` - Quit without saving
- `<Space>qq` - Save and quit

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
**Navigation:**
- `<Shift-h/l>` - Previous/Next buffer
- `<Tab>` - Next buffer
- `<Shift-Tab>` - Previous buffer
- `<Space>bn` - Next buffer
- `<Space>bp` - Previous buffer
- `<Space>bf` - First buffer
- `<Space>bl` - Last buffer

**Management:**
- `<Space>bd` - Close buffer
- `<Space>bo` - Close other buffers
- `<Space>ba` - Close all buffers

### Splits/Windows
**Navigation:**
- `<Ctrl-h/j/k/l>` - Move between windows
- `<Alt-h/j/k/l>` - Alternative navigation

**Create/Close:**
- `<Space>sv` - Vertical split
- `<Space>sh` - Horizontal split
- `<Space>sx` - Close current split
- `<Space>so` - Close other splits
- `<Space>sm` - Maximize/restore split

**Resize:**
- `<Shift-Arrows>` - Fast resize (±5)
- `<Ctrl-Arrows>` - Slow resize (±2)
- `<Space>s+/-` - Height ±10
- `<Space>s</>` - Width ±10
- `<Space>se` - Equal sizes

**Move windows:**
- `<Space>sH/J/K/L` - Move window left/down/up/right

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

### Comments
- `gcc` - Comment/uncomment line
- `gc` - Comment/uncomment (normal and visual)
- `<Space>/` - Toggle comment
- `<Ctrl-/>` - Toggle comment
- `gb` - Block comment (normal and visual)

### Multicursor
- `<A-n>` - Select next occurrence
- `<A-p>` - Select previous occurrence
- `<A-x>` - Skip current occurrence
- `<leader>mc` - Quit multicursor mode

### Notifications
- `<Space>nd` - Dismiss all notifications

### UI
- `<Space>ut` - Toggle transparency

### Visualization
- Spaces shown as dots (·)
- Tabs shown as double dots (::)
- Cursor with colorful tail animation
- Smooth scroll with animations
- Animated indent guides

### Themes
![alt text](pics/image-5.png)
- `<Space>ct` - Change theme (cycle through all)
- `:Theme tokyo` - Tokyo Night
- `:Theme cat` - Catppuccin Mocha
- `:Theme gruvbox` - Gruvbox Hard
- `:Theme kanagawa` - Kanagawa Wave
- `:Theme dracula` - Dracula
- `:Theme onedark` - One Dark
- `:Theme nord` - Nord
- `:Theme nightfox` - Nightfox
- `:Theme monokai` - Monokai Pro
- `:Theme cyber` - Cyberdream


![alt text](pics/image-1.png)![alt text](pics/image-2.png)![alt text](pics/image-3.png)![alt text](pics/image-4.png)![alt text](pics/image-6.png)![alt text](pics/image-7.png)![alt text](pics/image-8.png)![alt text](pics/image-9.png)![alt text](pics/image-10.png)![alt text](pics/image-11.png)


## ⌨️ Default Vim Keybindings

This configuration preserves most of the default Vim keybindings. Here are some of the most common ones:

### Inserting Text
- `i` - Insert before cursor
- `a` - Append after cursor
- `I` - Insert at the beginning of the line
- `A` - Append at the end of the line
- `o` - Open a new line below
- `O` - Open a new line above

### Editing Text
- `r` - Replace a single character
- `c` - Change (delete and enter insert mode)
- `C` - Change to the end of the line
- `s` - Substitute a character
- `S` - Substitute a line

### Undo/Redo
- `u` - Undo
- `<C-r>` - Redo

### Copy/Paste
- `y` - Yank (copy)
- `p` - Paste after cursor
- `P` - Paste before cursor

### Delete
- `x` - Delete character
- `dw` - Delete word
- `dd` - Delete line

### Movement
- `h/j/k/l` - Left/down/up/right
- `w/b` - Next/previous word
- `0/$` - Start/end of line
- `gg/G` - Start/end of file

### Search
- `/` - Search forward
- `?` - Search backward
- `n/N` - Next/previous occurrence

### Visual Mode
- `v` - Character-wise visual mode
- `V` - Line-wise visual mode
- `<C-v>` - Block-wise visual mode

### Marks and Jumps
- `m{a-z}` - Set a mark
- `'{a-z}` - Jump to a mark

### Macros
- `q{a-z}` - Record a macro
- `@{a-z}` - Execute a macro

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
    ├── editor.lua     # Editing tools
    ├── cmdline.lua    # Command line suggestions
    └── windows.lua    # Window management
```

### Change theme
**Option 1: Quick command**
```vim
:Theme cat        " Catppuccin
:Theme gruvbox    " Gruvbox
:Theme kanagawa   " Kanagawa
:Theme dracula    " Dracula
:Theme onedark    " One Dark
:Theme nord       " Nord
:Theme nightfox   " Nightfox
:Theme monokai    " Monokai Pro
:Theme cyber      " Cyberdream
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

### Add support for a new language

To add support for a new language, you need to:

1.  **Install the LSP server**:
    *   Run `:Mason` and install the corresponding language server.
2.  **Install the parser**:
    *   The parser will be installed automatically by `nvim-treesitter` if it's available.
    *   You can check the list of available parsers [here](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages).
3.  **Install the formatter**:
    *   Find a formatter for your language and install it.
    *   Add the formatter to the `conform.nvim` configuration in `lua/plugins/formatting.lua`.

Example for adding `rust`:

1.  Install `rust-analyzer` with `:Mason`.
2.  `nvim-treesitter` will install the `rust` parser automatically.
3.  Install `rustfmt` with `rustup component add rustfmt`.
4.  Add `rustfmt` to `lua/plugins/formatting.lua`:

    ```lua
    require("conform").setup({
      formatters_by_ft = {
        -- ...
        rust = { "rustfmt" },
        -- ...
      },
    })
    ```

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
