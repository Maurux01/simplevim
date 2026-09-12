-- =============================================
--  simplevim - Neovim fullstack config
--  Modular: lua/plugins/*.lua
--  Tema oscuro, cmdline bonito, 10/10
-- =============================================

-- ---------------------------------------------
--  1. BOOTSTRAP DE LAZY.NVIM
-- ---------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ---------------------------------------------
--  2. DESHABILITAR PROVIDERS INNECESARIOS
-- ---------------------------------------------
-- Cada provider checa si node/python/ruby/perl existen en el PATH
-- Esto ahorra ~50-150ms en el startup
vim.g.loaded_node_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- ---------------------------------------------
--  3. DESHABILITAR PLUGINS BUILTIN
-- ---------------------------------------------
-- Netrw: usamos nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Gzip, tar, zip: ralentizan deteccion de archivos
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- ---------------------------------------------
--  4. CONFIGURACION BASE
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
opt.updatetime = 250
opt.timeoutlen = 300
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append("aoOtTIc")
opt.showmode = false
opt.cmdheight = 1
opt.mouse = "a"
opt.clipboard = "unnamedplus"

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

vim.g.simplevim_theme = "catppuccin"

-- ---------------------------------------------
--  4. CARGAR MODULOS (keymaps ya, tema DESPUES de lazy)
-- ---------------------------------------------
require("keymaps")

-- ---------------------------------------------
--  5. CARGAR PLUGINS CON LAZY CACHE
-- ---------------------------------------------
-- Lazy.nvim ya cachea, pero esto fuerza re-uso del cache
local lazy = require("lazy")
lazy.setup("plugins", {
  install = { colorscheme = { "catppuccin", "habamax" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- ---------------------------------------------
--  6. APLICAR TEMA (despues de que lazy instalo/cargo todo)
-- ---------------------------------------------
require("theme").setup()
