# simplevim

Configuracion fullstack para Neovim, basada en [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) y gestionada con **Lazy.nvim**.

## Caracteristicas

- **Tema oscuro**: Catppuccin (mocha) por defecto; alternativa Tokyonight (night)
- **Statusline**: Lualine con iconos, git branch, diff, diagnostics y encoding
- **Cmdline UI**: wilder.nvim con menu visual, iconos, scroll y fzy highlight
- **LSP Progress**: fidget.nvim con barra de progreso sutil (sin popup molesto)
- **Indent Guides**: mini.indentscope con guias animadas
- **Keymap Discovery**: which-key muestra tus atajos al mantener una tecla
- **Numeros de linea reales** (absolutos, sin relativos)
- **Sin `~`** al final del buffer (fillchars personalizados)
- **Modular**: plugins organizados en `lua/plugins/*.lua` por categoria
- **Fullstack**: LSP para TypeScript, HTML, CSS, JSON (con schemas), Python, Tailwind, Docker, SQL, Bash, Lua, Emmet
- **Formateo**: Prettier/Prettierd via conform.nvim (JS/TS/HTML/CSS/JSON/YAML/Markdown...), LSP como fallback; formato al guardar
- **Autocompletado**: nvim-cmp con LSP, snippets (LuaSnip), buffer y path
- **Treesitter**: Highlight + indent para 20+ lenguajes
- **Utilidades**: autopairs, gitsigns, Comment.nvim, vim-surround
- **Velocidad**: Providers deshabilitados, plugins builtins off, lazy loading optimizado

## Estructura

```
init.lua                   Bootstrap de Lazy + opciones base + deshabilitar providers
lua/theme.lua              Aplicacion del tema oscuro
lua/keymaps.lua            Atajos de teclado globales
lua/plugins/
  appearance.lua           Temas, lualine, wilder, mini.icons, mini.indentscope
  editor.lua               Treesitter, autopairs, gitsigns, Comment, which-key, fidget
  lsp.lua                  Mason, LSP, nvim-cmp, schemastore
  navigation.lua           Telescope, nvim-tree
  fullstack.lua            Live server, markdown preview
  format.lua               Prettier/Prettierd via conform.nvim (formato al guardar)
script.sh                  Instalador automatizado (Linux/macOS/Windows con Git Bash)
script.ps1                 Instalador automatizado (Windows nativo, PowerShell)
```

## Instalacion

### Linux / macOS / Windows (Git Bash)

```bash
./script.sh                      # Instalacion normal
./script.sh -i                   # Modo interactivo
./script.sh -f                   # Forzar sin backup
./script.sh -b                   # Restaurar un backup
./script.sh -r usuario/repo -t develop   # Desde otro repo/rama
```

El script hace backup, limpia `~/.config/nvim`, `~/.local/share/nvim` y `~/.cache/nvim`, clona este repositorio y sincroniza los plugins con Lazy automaticamente.

> **Nota (Windows con Git Bash)**: `script.sh` tambien funciona en Windows si lo ejecutas desde Git Bash (`bash script.sh`). En ese caso usa las rutas nativas de Neovim en Windows: `%LOCALAPPDATA%\nvim` (config), `%LOCALAPPDATA%\nvim-data` (datos) y `%TEMP%\nvim` (cache).

### Windows

```powershell
.\script.ps1                     # Instalacion normal
.\script.ps1 -Interactive        # Modo interactivo
.\script.ps1 -Force              # Forzar sin backup
.\script.ps1 -Backup             # Restaurar un backup
.\script.ps1 -Repo "usuario/repo" -Branch "develop"  # Desde otro repo/rama
.\script.ps1 -LazySync           # Instalar y sincronizar plugins
```

El script usa `%LOCALAPPDATA%\nvim` (config), `%LOCALAPPDATA%\nvim-data` (datos) y `%TEMP%\nvim` (cache).

> **Nota**: Si PowerShell bloquea el script, ejecuta primero:
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
> ```

## Cambiar de tema

En `init.lua` cambia:

```lua
vim.g.simplevim_theme = "catppuccin"  -- o "tokyonight"
```

## Primer uso

Abre `nvim`. Lazy instalara los plugins automaticamente. Los servidores LSP se instalan via Mason (`:Mason`).

> **Requisitos externos**: Telescope necesita `rg` (ripgrep) para `live_grep` y `fd` para un `find_files` rapido. Sin ellos veras un aviso y funcionara degradado. Los scripts de instalacion te avisan si faltan.

Para ver el tiempo de carga:
```vim
:Lazy profile
:StartupTime
```

## Atajos

| Atajo | Accion |
|-------|--------|
| `<leader>e` | Explorador (nvim-tree) |
| `<leader>ff` | Buscar archivos (Telescope) |
| `<leader>fg` | Buscar en contenido |
| `<leader>fb` | Buffers (Telescope) |
| `<leader>fh` | Ayuda |
| `<leader>fr` | Archivos recientes |
| `<leader>fd` | Diagnosticos |
| `<leader>fs` | Simbolos del documento |
| `<leader>gc` / `<leader>gs` | Git commits / status |
| `<leader>gp` / `<leader>gb` | Git preview hunk / blame |
| `<leader>gr` / `<leader>gR` | Git reset hunk / buffer |
| `<leader>w` / `<leader>q` | Guardar / Cerrar |
| `<leader>Q` | Forzar cerrar todo |
| `<leader>rn` / `<leader>ca` | Renombrar / Code action |
| `<leader>lf` | Formatear archivo |
| `<leader>ld` | Diagnostico en linea |
| `<leader>T` | Abrir terminal |
| `<S-h>` / `<S-l>` | Buffer anterior / siguiente |
| `<leader>bd` | Cerrar buffer |
| `gd`, `K`, `gi`, `gr` | Ir a definicion / hover / implementacion / referencias |
| `<C-h/j/k/l>` | Moverse entre splits |
| `<C-Left/Right/Up/Down>` | Redimensionar splits |
| `gc` / `gcc` | Comentar linea/seleccion |

## LSPs incluidos

| Servidor | Lenguaje |
|----------|----------|
| `ts_ls` | TypeScript/JavaScript |
| `html` | HTML |
| `cssls` | CSS/SCSS/Less |
| `jsonls` | JSON (con SchemaStore para package.json, tsconfig, etc.) |
| `pyright` | Python |
| `tailwindcss` | Tailwind CSS |
| `lua_ls` | Lua |
| `emmet_ls` | HTML/CSS/React snippets |
| `bashls` | Bash/Shell |
| `dockerls` | Dockerfiles |
| `sqlls` | SQL |

## Optimizaciones de rendimiento

- Providers de node/python/ruby/perl deshabilitados (~50-150ms menos)
- 10 plugins builtins de Neovim deshabilitados (netrw, gzip, tar, zip, matchit, etc.)
- Treesitter: modulos `incremental_selection` y `context` deshabilitados
- gitsigns: `current_line_blame` deshabilitado
- nvim-cmp: debounce/throttle optimizados, deshabilitado en prompts
- Format-on-save async con validacion de buffer
- Lazy loading agresivo: la mayoria de plugins cargan por evento/tecla/comando
