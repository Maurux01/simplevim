-- lua/plugins/appearance.lua
-- Temas, statusline, cmdline, iconos, indent guides

return {
  -- ============================================
  --  TEMAS (solo uno carga, el otro queda deferred)
  -- ============================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = vim.g.simplevim_theme ~= "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
    end,
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = vim.g.simplevim_theme ~= "tokyonight",
    priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "night" })
    end,
  },

  -- ============================================
  --  STATUSLINE
  -- ============================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local theme_name = vim.g.simplevim_theme or "catppuccin"
      require("lualine").setup({
        options = {
          theme = theme_name,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "lazy", "mason", "dashboard" },
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
        extensions = { "nvim-tree", "telescope", "fugitive" },
      })
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ============================================
  --  CMDLINE UI (completado visual en : y /)
  -- ============================================
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = { "romgrk/fzy-lua-native" },
    config = function()
      local wilder = require("wilder")
      wilder.setup({
        modes = { ":", "/", "?" },
        next_key = "<Tab>",
        previous_key = "<S-Tab>",
        accept_key = "<Enter>",
        reject_key = "<C-e>",
      })

      wilder.set_option("renderer", wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          highlights = {
            border = "Normal",
          },
          border = "rounded",
          max_width = 60,
          max_height = 15,
          highlighter = wilder.lua_fzy_highlighter(),
          left = {
            " ",
            wilder.popupmenu_devicons(),
          },
          right = {
            " ",
            wilder.popupmenu_scrollbar(),
          },
        })
      ))
    end,
  },

  -- ============================================
  --  INDENT GUIDES
  -- ============================================
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup({
        symbol = "│",
        options = {
          try_as_border = true,
          indent_at_cursor = true,
        },
        draw = {
          delay = 150,
          anim = require("mini.indentscope").gen_animation.quadratic({
            easing = "out",
            duration = 200,
            unit = "total",
          }),
        },
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help", "alpha", "dashboard", "neo-tree", "Trouble",
          "lazy", "mason", "notify", "toggleterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- ============================================
  --  ICONOS ADICIONALES
  -- ============================================
  {
    "echasnovski/mini.icons",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("mini.icons").setup()
    end,
  },
}
