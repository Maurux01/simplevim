-- lua/theme.lua
-- Aplica el tema seleccionado
-- Cambia simplevim_theme en init.lua: "catppuccin" | "tokyonight"
local M = {}

function M.setup()
  local theme = vim.g.simplevim_theme or "catppuccin"
  vim.cmd("set background=dark")
  vim.cmd("colorscheme " .. theme)
end

return M
