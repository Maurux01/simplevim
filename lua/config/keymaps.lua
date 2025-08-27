-- Keymaps
local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines (Ctrl + Shift + jk)
map("n", "<C-S-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<C-S-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<C-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<C-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close other buffers" })
map("n", "<leader>ba", "<cmd>%bd<cr>", { desc = "Close all buffers" })

-- Window Management
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>we", "<C-w>=", { desc = "Equal windows" })
map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close other windows" })
map("n", "<leader>wm", "<cmd>MaximizerToggle<cr>", { desc = "Maximize toggle" })

-- Window Navigation (Alt + hjkl)
map("n", "<A-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<A-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<A-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<A-l>", "<C-w>l", { desc = "Go to right window" })

-- Window Swapping
map("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move window down" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })

-- Window Resizing (Shift + Arrow keys)
map("n", "<S-Up>", "<cmd>resize +5<cr>", { desc = "Increase height" })
map("n", "<S-Down>", "<cmd>resize -5<cr>", { desc = "Decrease height" })
map("n", "<S-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease width" })
map("n", "<S-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase width" })

-- Quick Window Actions
map("n", "<leader>w+", "<cmd>resize +10<cr>", { desc = "Increase height +10" })
map("n", "<leader>w-", "<cmd>resize -10<cr>", { desc = "Decrease height -10" })
map("n", "<leader>w>", "<cmd>vertical resize +10<cr>", { desc = "Increase width +10" })
map("n", "<leader>w<", "<cmd>vertical resize -10<cr>", { desc = "Decrease width -10" })

-- Legacy splits (mantener compatibilidad)
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })

-- Terminal
map("n", "<leader>th", "<cmd>split | terminal<cr>", { desc = "Terminal horizontal" })
map("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal vertical" })
map("n", "<leader>tt", "<cmd>tabnew | terminal<cr>", { desc = "Terminal tab" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal right" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Tabs
map("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabn<cr>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabp<cr>", { desc = "Prev tab" })

-- Which-key groups
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>b"] = { name = "󰓩 Buffer" },
      ["<leader>c"] = { name = " Code" },
      ["<leader>f"] = { name = " Find" },
      ["<leader>g"] = { name = " Git" },
      ["<leader>gh"] = { name = "󰊢 Hunks" },
      ["<leader>s"] = { name = "󰓩 Split" },
      ["<leader>t"] = { name = " Tab/Terminal" },
      ["<leader>w"] = { name = " Window" },
      ["<leader>x"] = { name = " Diagnostics" },
    })
  end,
})