-- lua/theme.lua
-- Aplica el tema oscuro seleccionado
-- Cambia el valor de simplevim_theme en init.lua para elegir:
--   "catppuccin" | "tokyonight"
local M = {}

function M.setup()
  local theme = vim.g.simplevim_theme or "catppuccin"

  vim.cmd("set background=dark")

  if theme == "tokyonight" then
    require("tokyonight").setup({
      style = "night",
      transparent = false,
    })
    vim.cmd("colorscheme tokyonight")
    return
  end

  require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
  })
  vim.cmd.colorscheme("catppuccin")
end

return M