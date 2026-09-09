-- lua/keymaps.lua
-- Atajos de teclado globales

-- Guardar y salir
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Guardar" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Cerrar" })

-- Navegacion de archivos
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Explorador de archivos" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Buscar archivos" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Buscar en contenido" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Lista de buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Ayuda" })

-- Moverse entre splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Split izquierdo" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Split abajo" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Split arriba" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Split derecho" })

-- Algunas terminales envian Ctrl+h como backspace
vim.keymap.set("n", "<BS>", "<C-w>h", { desc = "Split izquierdo (backspace)" })

-- Redimensionar splits
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Ancho -2" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Ancho +2" })
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Alto -2" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Alto +2" })