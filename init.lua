-- ~/.config/nvim/init.lua (version minima)
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd("packadd packer.nvim")
  print("Packer instalado. Reinicia Neovim.")
  return
end

vim.cmd("packadd packer.nvim")

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("catppuccin/nvim")
end)

vim.cmd("colorscheme catppuccin")
