# simplevim

Configuracion fullstack para Neovim, basada en [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) y gestionada con **Lazy.nvim**.

## Caracteristicas

- **Tema oscuro**: Catppuccin (mocha) por defecto; alternativa Tokyonight (night)
- **Barra de estado bonita**: Lualine con iconos, git branch, diff y diagnostics
- **Numeros de linea reales** (absolutos, sin relativos)
- **Sin `~`** al final del buffer (fillchars)
- **Sin banner** de bienvenida de Neovim (shortmess + limpieza al entrar)
- **Fullstack**: LSP (TypeScript, HTML, CSS, JSON, Python, Go, Ruby, Rust, Tailwind, Lua), autocompletado con nvim-cmp, Treesitter, Telescope, nvim-tree
- **Utilidades**: autopairs, gitsigns, Comment.nvim, vim-surround

## Estructura

```
init.lua                 Bootstrap de Lazy + opciones base
lua/plugins.lua          Definicion de todos los plugins
lua/theme.lua            Aplicacion del tema oscuro
lua/keymaps.lua          Atajos de teclado
script.sh                Instalador automatizado
```

## Instalacion

```bash
./script.sh                      # Instalacion normal
./script.sh -i                   # Modo interactivo
./script.sh -f                   # Forzar sin backup
./script.sh -b                   # Restaurar un backup
./script.sh -r usuario/repo -t develop   # Desde otro repo/rama
```

El script hace backup, limpia `~/.config/nvim`, `~/.local/share/nvim` y `~/.cache/nvim`, clona este repositorio y sincroniza los plugins con Lazy automaticamente.

## Cambiar de tema

En `init.lua` cambia:

```lua
vim.g.simplevim_theme = "catppuccin"  -- o "tokyonight"
```

## Primer uso

Abre `nvim`. Lazy instalara los plugins automaticamente. Los servidores LSP se instalan via Mason (`:Mason`).

## Atajos

| Atajo | Accion |
|-------|--------|
| `<leader>e` | Explorador (nvim-tree) |
| `<leader>ff` | Buscar archivos (Telescope) |
| `<leader>fg` | Buscar en contenido |
| `<leader>fb` | Buffers |
| `<leader>fh` | Ayuda |
| `<leader>w` / `<leader>q` | Guardar / Cerrar |
| `gd`, `K`, `gr`, `<leader>rn`, `<leader>ca` | Atajos LSP |
| `<C-h/j/k/l>` | Moverse entre splits |