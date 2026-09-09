-- =============================================
--  simplevim - Neovim fullstack config
--  Base: kickstart.nvim + Lazy.nvim
--  Tema oscuro, lualine bonita, sin '~',
--  sin banner, numeros reales
-- =============================================

-- ---------------------------------------------
--  1. BOOTSTRAP DE LAZY.NVIM
-- ---------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ---------------------------------------------
--  2. CONFIGURACION BASICA (NEOVIM DEFAULTS)
-- ---------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.termguicolors = true
opt.updatetime = 300
opt.timeoutlen = 300
opt.swapfile = false
opt.backup = false
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.signcolumn = "yes"
opt.cursorline = true

opt.shortmess = "aoOtTI"
opt.showmode = false
opt.cmdheight = 1

opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = " ",
  foldclose = " ",
  foldsep = " ",
  diff = " ",
  msgsep = " ",
  vert = "|",
}

-- Tema oscuro (elige "catppuccin" o "tokyonight")
vim.g.simplevim_theme = "catppuccin"

-- ---------------------------------------------
--  3. CARGAR MODULOS
-- ---------------------------------------------
require("lazy").setup("plugins")
require("theme").setup()
require("keymaps")