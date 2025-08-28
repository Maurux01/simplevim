return {
  {
    "folke/zen-mode.nvim",
    opts = {
      -- Configuration for the main zen-mode window
      window = {
        -- Set the width of the zen window.
        -- It can be a number (columns) or a string (percentage), e.g. "70%"
        width = 90, -- Aim for 80-100 columns for readability

        -- Options for the zen window
        options = {
          -- Hide the sign column
          signcolumn = "no",
          -- Hide line numbers
          number = false,
          relativenumber = false,
          -- Hide the cursor line
          cursorline = false,
          -- Hide the cursor column
          cursorcolumn = false,
          -- Hide the fold column
          foldcolumn = "0",
          -- Hide list characters
          list = false,
        },
      },
      -- Configuration for plugins integration
      plugins = {
        -- Enable twilight integration
        -- When zen-mode is activated, twilight will be enabled automatically
        twilight = {
          enabled = true,
        },
        -- Keep gitsigns enabled in zen-mode
        gitsigns = {
          enabled = true,
        },
        -- Keep tmux pane active in zen-mode
        tmux = {
          enabled = true,
        },
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      -- Configuration for the dimming
      dimming = {
        -- Alpha value for the dimmed text
        -- A lower value means more dimming
        -- (0-1, where 0 is fully transparent and 1 is fully opaque)
        alpha = 0.25,
        -- Do not dim inactive windows
        inactive = false,
      },
      -- Number of lines to keep visible around the cursor
      context = 10,
    },
  },
}