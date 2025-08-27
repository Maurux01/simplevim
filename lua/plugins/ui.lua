return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "tokyonight",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          },
          lualine_x = {
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            },
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            },
            { "encoding" },
            { "fileformat" },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%H:%M:%S")
            end,
          },
        },
      }
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = { Error = " ", Warn = " ", Info = " " }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                   ",
        "   ⣴⣶⣤⢤⣆⣤⠤⣤⠆     ⢈⣭⣿⣶⣿⣦⣴⣆          ",
        "    ⠉⠛⣿⣿⣿⣿⣶⣦⣤⣠⣠⣾⣿⣿⣿⡿⠋⠉⠉⠛⣿⣿⣛⣦       ",
        "          ⠈⣿⣿⣟⣆ ⣾⣿⣿⣷    ⠛⠿⣿⣧⣄     ",
        "           ⣸⣿⣿⣧ ⣻⠛⣿⣿⣷⣄⣠⣄⣠⣀⠈⠿⠄    ",
        "          ⣠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣿⣟⣳⣤⣠⣠   ",
        "   ⣠⣧⣶⣤⣄ ⣸⣿⣿⠘  ⣀⣴⣿⣿⣿⡿⠛⣿⣿⣧⠈⣿⠿⠟⠛⠿⠄  ",
        "  ⣰⣿⣿⠛⠛⣿⣿⣆⣹⣿⣷   ⢊⣿⣿⡏  ⣸⣿⣿⠇ ⣀⣠⣄⣾⠄   ",
        " ⣠⣿⠿⠋ ⣀⣿⣿⣷⠘⣿⣿⣆⣀ ⣸⣟⣿⣿⣄ ⣸⣿⣿⠇⣪⣿⡿⠿⣿⣷⣄  ",
        " ⠙⠃   ⣼⣿⡟  ⠈⠛⣿⣿⣆⣌⠇⠛⣿⣿⣷⣿⣿⣿ ⣿⣿⠇ ⠛⠷⣄ ",
        "      ⣻⣿⣿⣄   ⠈⠛⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⡟ ⠫⣿⣿⠆     ",
        "       ⠛⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣀⣠⣤⣾⡿⠃     ",
        "                                   ",
        "           S I M P L E V I M        ",
        "          fast • simple • cute         ",
        "                                   ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", "<cmd>Telescope find_files<cr>"),
        dashboard.button("n", "  New File", "<cmd>ene <BAR> startinsert<cr>"),
        dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("g", "  Find Text", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("e", "  File Explorer", "<cmd>Neotree toggle<cr>"),
        dashboard.button("c", "  Config", "<cmd>e $MYVIMRC<cr>"),
        dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<cr>"),
        dashboard.button("m", "  Mason", "<cmd>Mason<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
      }

      -- Footer
      local function footer()
        local total_plugins = #vim.tbl_keys(require("lazy").plugins())
        local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
        local version = vim.version()
        local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

        return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
      end

      dashboard.section.footer.val = footer()

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  },

  -- Configuración de colores para cursor animado
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.smoothcursor_red = "#f7768e"
        colors.smoothcursor_orange = "#ff9e64"
        colors.smoothcursor_yellow = "#e0af68"
        colors.smoothcursor_green = "#9ece6a"
        colors.smoothcursor_aqua = "#73daca"
        colors.smoothcursor_blue = "#7aa2f7"
        colors.smoothcursor_purple = "#bb9af7"
      end,
      on_highlights = function(hl, c)
        hl.SmoothCursor = { fg = c.fg_gutter }
        hl.SmoothCursorRed = { fg = c.smoothcursor_red }
        hl.SmoothCursorOrange = { fg = c.smoothcursor_orange }
        hl.SmoothCursorYellow = { fg = c.smoothcursor_yellow }
        hl.SmoothCursorGreen = { fg = c.smoothcursor_green }
        hl.SmoothCursorAqua = { fg = c.smoothcursor_aqua }
        hl.SmoothCursorBlue = { fg = c.smoothcursor_blue }
        hl.SmoothCursorPurple = { fg = c.smoothcursor_purple }
      end,
    },
  },
}