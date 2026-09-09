-- lua/keymaps.lua
-- Atajos de teclado globales

local map = vim.keymap.set

-- Guardar y salir
map("n", "<leader>w", ":w<CR>", { desc = "Guardar" })
map("n", "<leader>q", ":q<CR>", { desc = "Cerrar" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Forzar cerrar todo" })

-- Explorador de archivos
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Explorador de archivos" })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Buscar archivos" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Buscar en contenido" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Lista de buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Ayuda" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Archivos recientes" })
map("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "Diagnostico" })

-- Buffers
map("n", "<S-h>", ":bprevious<CR>", { desc = "Buffer anterior" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Buffer siguiente" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Cerrar buffer" })
map("n", "<leader>bl", ":Telescope buffers<CR>", { desc = "Listar buffers" })

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
