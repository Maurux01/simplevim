-- Options
local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Whitespace visualization
opt.list = true
opt.listchars = {
  space = "·",
  tab = "::",
  extends = ">",
  precedes = "<",
  nbsp = "␣"
}
opt.fillchars = {
  eob = " "
}

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 150
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Terminal completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"