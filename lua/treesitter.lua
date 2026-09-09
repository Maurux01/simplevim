-- lua/treesitter.lua
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "vim", "vimdoc",
    "javascript", "typescript", "tsx", "html", "css", "json",
    "python", "go", "ruby", "rust", "yaml", "toml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  -- Opcional: navegación entre funciones/estructuras
  rainbow = {
    enable = true,
    extended_mode = true,
  },
})

-- Atajos para navegar entre nodos (opcional)
vim.keymap.set("n", "<leader>n", function()
  vim.cmd("TSNodeInfo")
end, { desc = "Información del nodo bajo cursor" })
