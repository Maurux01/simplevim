-- lua/plugins.lua
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Clonar packer si no está instalado
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
end

-- Cargar packer y definir plugins
return require("packer").startup(function(use)
  -- El propio packer
  use("wbthomason/packer.nvim")

  -- -------------------------------------------
  -- Plugins de apariencia y utilidades
  -- -------------------------------------------
  use({
    "nvim-lualine/lualine.nvim",        -- Barra de estado elegante
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "tokyonight" } })
    end,
  })

  use({
    "catppuccin/nvim",                  -- Tema de colores (rápido)
    as = "catppuccin",
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  })

  -- -------------------------------------------
  -- Navegación y archivos
  -- -------------------------------------------
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  })

  use({
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  })

  -- -------------------------------------------
  -- LSP (Language Server Protocol)
  -- -------------------------------------------
  use({
    "neovim/nvim-lspconfig",           -- Configuración de servidores LSP
    event = "BufReadPre",              -- Carga perezosa al abrir archivo
  })

  use({
    "williamboman/mason.nvim",         -- Instalación de servidores LSP/DAP
    event = "BufReadPre",
    config = function()
      require("mason").setup()
    end,
  })

  use({
    "williamboman/mason-lspconfig.nvim", -- Puente entre mason y lspconfig
    event = "BufReadPre",
    requires = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
  })

  -- -------------------------------------------
  -- Autocompletado (nvim-cmp)
  -- -------------------------------------------
  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",             -- Se carga al entrar en modo inserción
    requires = {
      "hrsh7th/cmp-nvim-lsp",          -- Fuente LSP
      "hrsh7th/cmp-buffer",            -- Fuente del buffer
      "hrsh7th/cmp-path",              -- Fuente de rutas
      "L3MON4D3/LuaSnip",              -- Snippets (engine)
      "saadparwaiz1/cmp_luasnip",      -- Fuente de snippets
    },
  })

  -- -------------------------------------------
  -- Treesitter (resaltado y navegación)
  -- -------------------------------------------
  use({
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    run = ":TSUpdate",                 -- Actualiza parsers al instalar
  })

  -- -------------------------------------------
  -- Utilidades extra
  -- -------------------------------------------
  use({
    "windwp/nvim-autopairs",           -- Cierra paréntesis, comillas, etc.
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  })

  use({
    "numToStr/Comment.nvim",           -- Comentarios rápidos
    keys = { "gc", "gcc" },            -- Carga cuando se usan estas teclas
    config = function()
      require("Comment").setup()
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",         -- Signos de git en el margen
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  })
end)
