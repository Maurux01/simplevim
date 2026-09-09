-- lua/plugins.lua
-- Todos los plugins gestionados con Lazy.nvim (estilo kickstart)
return {
  -- ============================================
  --  APARIENCIA
  -- ============================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
    end,
  },

  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    priority = 1001,
    config = function()
      vim.g.tokyonight_style = "night"
      require("tokyonight").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "NvimTree", "lazy" },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            { "mode", fmt = function(str) return " " .. str .. " " end },
          },
          lualine_b = { "branch", "diff" },
          lualine_c = {
            { "filename", file_status = true, path = 1 },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = "E ", warn = "W ", info = "I ", hint = "H " },
            },
            "encoding",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "nvim-tree", "telescope" },
      })
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ============================================
  --  NAVEGACION Y ARCHIVOS
  -- ============================================
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git", "dist", "build" },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        filters = { dotfiles = true },
        git = { ignore = false },
        view = { width = 30 },
        renderer = {
          icons = {
            show = { file = true, folder = true, folder_arrow = true, git = true },
          },
        },
      })
    end,
  },

  -- ============================================
  --  LSP
  -- ============================================
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "pyright",
        "gopls",
        "ruby_lsp",
        "rust_analyzer",
        "tailwindcss",
        "lua_ls",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      vim.lsp.config("all", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufopts = { noremap = true, silent = true, buffer = args.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, bufopts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(ev)
          local clients = vim.lsp.get_clients({ bufnr = ev.buf })
          if #clients > 0 then
            vim.lsp.buf.format({ bufnr = ev.buf, async = false })
          end
        end,
      })
    end,
  },

  -- ============================================
  --  AUTOCOMPLETADO
  -- ============================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "path" } },
      })
    end,
  },

  -- ============================================
  --  TREESITTER
  -- ============================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter")
      if not ok then return end
      ts.setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "javascript", "typescript", "tsx", "html", "css", "json",
          "yaml", "python", "go", "ruby", "rust", "toml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- ============================================
  --  UTILIDADES
  -- ============================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup()
    end,
  },

  { "tpope/vim-surround", keys = { "ys", "ds", "cs" } },
}