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
- **Temas**: 6 temas oscuros (Tokyo Night, Catppuccin, Gruvbox, Kanagawa, Dracula, OneDark)
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
- **Animaciones**: Cursor animado, scroll suave, indent guides
- **Which-key**: Guía visual de atajos de teclado
- **Whitespace**: Visualización de espacios y tabs

## 🚀 Instalación

### 1. Requisitos
- Neovim 0.9+
- Git
- Node.js (para LSP de TypeScript)
- Python (para LSP de Python)

### 2. Instalación automática

**Opción 1: Instalador automático (Recomendado)**

```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/simplevim.git
cd simplevim

# Windows
install.bat

# Linux/macOS
chmod +x install.sh
./install.sh
```

**Opción 2: Instalación manual**

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
- `<Space>` - Tecla líder (muestra which-key después de 300ms)
- `<Ctrl-s>` - Guardar archivo
- `<Esc>` - Limpiar búsqueda

### Navegación
- `<Ctrl-h/j/k/l>` - Moverse entre ventanas
- `<Shift-h/l>` - Cambiar entre buffers
- `<Ctrl-Shift-j/k>` - Mover líneas arriba/abajo

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

### Control de Ventanas
**Navegación:**
- `<Ctrl-h/j/k/l>` - Moverse entre ventanas
- `<Alt-h/j/k/l>` - Navegación alternativa

**Crear/Cerrar:**
- `<Space>wv` - Split vertical
- `<Space>wh` - Split horizontal
- `<Space>wx` - Cerrar ventana actual
- `<Space>wo` - Cerrar otras ventanas
- `<Space>wm` - Maximizar/restaurar ventana

**Redimensionar:**
- `<Shift-Flechas>` - Redimensionar rápido (±5)
- `<Ctrl-Flechas>` - Redimensionar lento (±2)
- `<Space>w+/-` - Altura ±10
- `<Space>w</>` - Ancho ±10
- `<Space>we` - Igualar tamaños

**Mover ventanas:**
- `<Space>wH/J/K/L` - Mover ventana a lado/abajo/arriba/derecha

**Compatibilidad (legacy):**
- `<Space>sv/sh/se/sx` - Splits clásicos

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

### Visualización
- Espacios mostrados como puntos (·)
- Tabs mostrados como dos puntos (::)
- Cursor con animación de cola colorida
- Scroll suave con animaciones
- Indent guides animados

### Temas
- `<Space>ct` - Cambiar tema (cicla entre todos)
- `:Theme tokyo` - Tokyo Night
- `:Theme cat` - Catppuccin Mocha
- `:Theme gruvbox` - Gruvbox Hard
- `:Theme kanagawa` - Kanagawa Wave
- `:Theme dracula` - Dracula
- `:Theme onedark` - One Dark

## 🎨 Personalización

La configuración está organizada en módulos:

```
lua/
├── config/
│   ├── options.lua    # Opciones de Neovim + whitespace
│   ├── keymaps.lua    # Atajos de teclado + which-key
│   └── lazy.lua       # Configuración de lazy.nvim
└── plugins/
    ├── animations.lua # Cursor, scroll, which-key, indent
    ├── colorscheme.lua # Tema
    ├── lsp.lua        # Language Server Protocol
    ├── cmp.lua        # Autocompletado
    ├── telescope.lua  # Búsqueda
    ├── neo-tree.lua   # Explorador
    ├── ui.lua         # Interfaz + colores cursor
    ├── git.lua        # Git integration
    ├── formatting.lua # Formato automático
    ├── treesitter.lua # Syntax highlighting
    ├── snippets.lua   # Snippets personalizados
    └── editor.lua     # Herramientas de edición
```

### Cambiar tema
**Opción 1: Comando rápido**
```vim
:Theme cat        " Catppuccin
:Theme gruvbox    " Gruvbox
:Theme kanagawa   " Kanagawa
:Theme dracula    " Dracula
:Theme onedark    " One Dark
:Theme tokyo      " Tokyo Night (por defecto)
```

**Opción 2: Atajo de teclado**
- `<Space>ct` - Cicla entre todos los temas

**Opción 3: Cambiar tema por defecto**
Edita `lua/plugins/colorscheme.lua` y cambia la línea:
```lua
vim.cmd([[colorscheme tokyonight]])
```

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
