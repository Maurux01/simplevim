return {
  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      })
    end,
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
      })
    end,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        contrast = "hard",
      })
    end,
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = "wave",
      })
    end,
  },

  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    config = function()
      require("dracula").setup({
        colors = {},
        show_end_of_buffer = true,
        transparent_bg = false,
        lualine_bg_color = "#44475a",
        italic_comment = true,
      })
    end,
  },

  -- One Dark
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "dark",
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },
      })
    end,
  },

  -- Configuración inicial y comando para cambiar temas
  {
    "folke/tokyonight.nvim",
    config = function()
      -- Tema por defecto
      vim.cmd([[colorscheme tokyonight]])
      
      -- Comando para cambiar temas fácilmente
      vim.api.nvim_create_user_command("Theme", function(opts)
        local themes = {
          tokyo = "tokyonight",
          cat = "catppuccin",
          gruvbox = "gruvbox",
          kanagawa = "kanagawa",
          dracula = "dracula",
          onedark = "onedark",
        }
        
        local theme = themes[opts.args] or opts.args
        if theme then
          vim.cmd("colorscheme " .. theme)
          print("Tema cambiado a: " .. theme)
        else
          print("Temas disponibles: tokyo, cat, gruvbox, kanagawa, dracula, onedark")
        end
      end, {
        nargs = 1,
        complete = function()
          return { "tokyo", "cat", "gruvbox", "kanagawa", "dracula", "onedark" }
        end,
      })
      
      -- Atajo de teclado para cambiar tema rápido
      vim.keymap.set("n", "<leader>ct", function()
        local themes = { "tokyonight", "catppuccin", "gruvbox", "kanagawa", "dracula", "onedark" }
        local current = vim.g.colors_name or "tokyonight"
        local current_idx = 1
        
        for i, theme in ipairs(themes) do
          if theme == current then
            current_idx = i
            break
          end
        end
        
        local next_idx = (current_idx % #themes) + 1
        local next_theme = themes[next_idx]
        
        vim.cmd("colorscheme " .. next_theme)
        print("Tema: " .. next_theme)
      end, { desc = "Cambiar tema" })
    end,
  },
}