-- lua/plugins/editor.lua
-- Treesitter, autopairs, Comment, gitsigns, surround, which-key, fidget

return {
  -- ============================================
  --  TREESITTER
  -- ============================================
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- la rama main elimino el modulo configs; master conserva la API setup()
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "javascript", "typescript", "tsx", "html", "css", "scss",
          "json", "jsonc", "yaml", "toml",
          "python", "bash", "markdown", "markdown_inline",
          "sql", "dockerfile", "regex", "diff",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        -- Deshabilitar modulos pesados que no usas
        incremental_selection = {
          enable = false,
        },
        context = {
          enable = false,
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        per_filetype = {
          html = { enable = true },
          javascriptreact = { enable = true },
          typescriptreact = { enable = true },
          vue = { enable = true },
          xml = { enable = true },
        },
      })
    end,
  },

  -- ============================================
  --  AUTOPAIRS
  -- ============================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })
    end,
  },

  -- ============================================
  --  COMENTARIOS
  -- ============================================
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gb", "gbc" },
    config = function()
      require("Comment").setup()
    end,
  },

  -- ============================================
  --  GIT SIGNS
  -- ============================================
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        current_line_blame = false,
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end
          map("n", "]h", gs.next_hunk, "Siguiente hunk")
          map("n", "[h", gs.prev_hunk, "Hunk anterior")
          map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>gb", gs.blame_line, "Blame linea")
          map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
          map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
          map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
        end,
      })
    end,
  },

  -- ============================================
  --  SURROUND
  -- ============================================
  { "tpope/vim-surround", keys = { "ys", "ds", "cs" } },

  -- ============================================
  --  WHICH-KEY (descubre tus keymaps)
  -- ============================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        delay = 400,
        icons = { breadcrumb = "»", separator = "➜", group = "+" },
        win = {
          border = "rounded",
          padding = { 1, 2 },
        },
        spec = {
          { "<leader>g", group = "git" },
          { "<leader>b", group = "buffer" },
          { "<leader>f", group = "find" },
          { "<leader>l", group = "lsp" },
          { "<leader>r", group = "rename" },
          { "<leader>t", group = "terminal" },
        },
      })
    end,
  },

  -- ============================================
  --  LSP PROGRESS (barra de progreso sutil)
  -- ============================================
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup({
        progress = {
          display = {
            render_limit = 16,
            done_ttl = 3,
            done_icon = "✓",
            group_style = "",
            icon_style = "",
            progress_style = "",
            log_style = "",
          },
        },
        notification = {
          window = {
            winblend = 0,
            border = "rounded",
          },
        },
      })
    end,
  },
}
