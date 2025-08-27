# 🚀 simplevim
**fast simple cute nvim** - Configuración mínima, moderna y funcional de Neovim

## ✨ Características

- ⚡ **Ultra rápido**: Carga en < 0.3 segundos
- 🎨 **Hermoso**: Tema Tokyo Night con UI moderna
- 🧠 **Inteligente**: LSP, autocompletado, formato automático
- 📁 **Funcional**: Explorador de archivos, búsqueda, git integrado
- 🔧 **Mínimo**: Solo lo esencial, sin bloat

## 📦 Plugins incluidos

- **Plugin Manager**: `lazy.nvim` (el más rápido)
- **Tema**: `tokyonight.nvim` (oscuro y moderno)
- **LSP**: `mason.nvim` + `lspconfig` (Lua, Python, TypeScript)
- **Autocompletado**: `nvim-cmp` + `LuaSnip` + `friendly-snippets`
- **Explorador**: `neo-tree.nvim` (con íconos)
- **Búsqueda**: `telescope.nvim` (archivos y texto)
- **UI**: `lualine.nvim` + `bufferline.nvim` + `alpha-nvim`
- **Git**: `gitsigns.nvim` (cambios en el margen)
- **Formato**: `conform.nvim` (automático al guardar)
- **Syntax**: `nvim-treesitter` (highlighting avanzado)
- **Edición**: Auto-pairs, surround, comentarios
- **Snippets**: LuaSnip con snippets personalizados

## 🚀 Instalación

### 1. Requisitos
- Neovim 0.9+
- Git
- Node.js (para LSP de TypeScript)
- Python (para LSP de Python)

### 2. Instalar configuración

**Windows:**
```cmd
# Respaldar configuración existente (opcional)
ren %LOCALAPPDATA%\nvim %LOCALAPPDATA%\nvim.backup

# Clonar simplevim
git clone https://github.com/tu-usuario/simplevim.git %LOCALAPPDATA%\nvim
```

**Linux/macOS:**
```bash
# Respaldar configuración existente (opcional)
mv ~/.config/nvim ~/.config/nvim.backup

# Clonar simplevim
git clone https://github.com/tu-usuario/simplevim.git ~/.config/nvim
```

### 3. Primera ejecución

```bash
nvim
```

La primera vez se instalarán automáticamente todos los plugins. Espera a que termine y reinicia Neovim.

## ⌨️ Atajos de teclado principales

### General
- `<Space>` - Tecla líder
- `<Ctrl-s>` - Guardar archivo
- `<Esc>` - Limpiar búsqueda

### Navegación
- `<Ctrl-h/j/k/l>` - Moverse entre ventanas
- `<Shift-h/l>` - Cambiar entre buffers
- `<Alt-j/k>` - Mover líneas arriba/abajo

### Explorador de archivos
- `<Space>e` - Abrir/cerrar Neo-tree

### Búsqueda (Telescope)
- `<Space>ff` - Buscar archivos
- `<Space>fg` - Buscar texto
- `<Space>fb` - Buscar buffers
- `<Space>fr` - Archivos recientes

### LSP
- `gd` - Ir a definición
- `K` - Mostrar documentación
- `<Space>rn` - Renombrar
- `<Space>ca` - Acciones de código
- `<Space>f` - Formatear código

### Git
- `]h` / `[h` - Siguiente/anterior cambio
- `<Space>ghs` - Stage hunk
- `<Space>ghr` - Reset hunk
- `<Space>ghp` - Preview hunk

### Buffers
- `<Space>bd` - Cerrar buffer
- `<Space>bo` - Cerrar otros buffers
- `<Space>ba` - Cerrar todos los buffers
- `<Space>bp` - Pin/unpin buffer

### Splits y Ventanas
- `<Space>sv` - Split vertical
- `<Space>sh` - Split horizontal
- `<Space>se` - Igualar splits
- `<Space>sx` - Cerrar split

### Terminal
- `<Space>th` - Terminal horizontal
- `<Space>tv` - Terminal vertical
- `<Space>tt` - Terminal en nueva pestaña
- `<Esc>` - Salir del modo terminal (en terminal)
- `<Ctrl-h/j/k/l>` - Navegar desde terminal

### Pestañas
- `<Space>to` - Nueva pestaña
- `<Space>tx` - Cerrar pestaña
- `<Space>tn` - Siguiente pestaña
- `<Space>tp` - Pestaña anterior

## 🎨 Personalización

La configuración está organizada en módulos:

```
lua/
├── config/
│   ├── options.lua    # Opciones de Neovim
│   ├── keymaps.lua    # Atajos de teclado
│   └── lazy.lua       # Configuración de lazy.nvim
└── plugins/
    ├── colorscheme.lua # Tema
    ├── lsp.lua        # Language Server Protocol
    ├── cmp.lua        # Autocompletado
    ├── telescope.lua  # Búsqueda
    ├── neo-tree.lua   # Explorador
    ├── ui.lua         # Interfaz (lualine, bufferline, alpha)
    ├── git.lua        # Git integration
    ├── formatting.lua # Formato automático
    ├── treesitter.lua # Syntax highlighting
    ├── snippets.lua   # Snippets personalizados
    └── editor.lua     # Herramientas de edición
```

### Cambiar tema
Edita `lua/plugins/colorscheme.lua` y cambia `tokyonight` por otro tema como `catppuccin`.

### Agregar LSP para otros lenguajes
Edita `lua/plugins/lsp.lua` y agrega el servidor en `ensure_installed`.

## 🔧 Comandos útiles

- `:Lazy` - Gestionar plugins
- `:Mason` - Instalar LSP servers
- `:checkhealth` - Verificar configuración
- `:ConformInfo` - Info de formatters

## 🐛 Solución de problemas

### Los íconos no se ven bien
Instala una Nerd Font: https://www.nerdfonts.com/

### LSP no funciona
```vim
:Mason
```
Instala el servidor correspondiente (lua_ls, pyright, tsserver, etc.)

### Formato automático no funciona
Verifica que tengas los formatters instalados:
```bash
npm install -g prettier  # Para JS/TS/JSON/HTML/CSS
pip install black isort  # Para Python
```

## 📄 Licencia

MIT License - Úsalo como quieras 🎉
