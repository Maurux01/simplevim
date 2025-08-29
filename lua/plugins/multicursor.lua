return {
  {
    "terryma/vim-multiple-cursors",
    keys = {
      { "<C-n>", mode = { "n", "v" }, desc = "Multiple Cursors: Next" },
      { "<C-p>", mode = { "n", "v" }, desc = "Multiple Cursors: Previous" },
      { "<C-x>", mode = { "n", "v" }, desc = "Multiple Cursors: Skip" },
    },
    config = function()
      vim.g.multi_cursor_use_default_mapping = 0
      vim.g.multi_cursor_next_key = "<C-n>"
      vim.g.multi_cursor_prev_key = "<C-p>"
      vim.g.multi_cursor_skip_key = "<C-x>"
      vim.g.multi_cursor_quit_key = "<esc>"
    end,
  },
}
