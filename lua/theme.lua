-- lua/theme.lua
-- Aplica el tema seleccionado
-- Cambia simplevim_theme en init.lua: "catppuccin" | "tokyonight"
local M = {}

function M.setup()
  local theme = vim.g.simplevim_theme or "catppuccin"
  vim.cmd("set background=dark")
  -- pcall: en el primer arranque el plugin del tema aún no está instalado/
  -- cargado por lazy.nvim, así que no debe romper el inicio.
  local ok, err = pcall(vim.cmd, "colorscheme " .. theme)
  if not ok then
    -- fallback silencioso a un esquema siempre disponible
    pcall(vim.cmd, "colorscheme habamax")
  end
end

return M
