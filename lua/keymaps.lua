-- lua/keymaps.lua
-- Atajos de teclado globales

local map = vim.keymap.set

-- Guardar y salir
map("n", "<leader>w", ":w<CR>", { desc = "Guardar" })
map("n", "<leader>q", ":q<CR>", { desc = "Cerrar" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Forzar cerrar todo" })

-- Explorador (nvim-tree) y Telescope: definidos como `keys` con lazy-load
-- en lua/plugins/navigation.lua. No duplicarlos aqui: el spec `keys`
-- carga el plugin al presionar la tecla y es la unica fuente de verdad.

-- Buffers
map("n", "<S-h>", ":bprevious<CR>", { desc = "Buffer anterior" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Buffer siguiente" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Cerrar buffer" })

-- Navegacion de splits
map("n", "<C-h>", "<C-w>h", { desc = "Split izquierdo" })
map("n", "<C-j>", "<C-w>j", { desc = "Split abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Split arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Split derecho" })

-- Redimensionar splits
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Ancho -2" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Ancho +2" })
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Alto -2" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Alto +2" })

-- Terminal
map("n", "<leader>T", ":terminal<CR>", { desc = "Abrir terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Salir del terminal" })
map("t", "<C-x>", "<C-\\><C-n>:close<CR>", { desc = "Cerrar terminal" })

-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Limpiar busqueda" })

-- Mejores indentaciones en visual
map("v", "<", "<gv", { desc = "Indentar izquierda" })
map("v", ">", ">gv", { desc = "Indentar derecha" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover linea abajo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover linea arriba" })
