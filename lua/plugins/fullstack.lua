-- lua/plugins/fullstack.lua
-- Live server, markdown preview, Treesitter extra parsers

return {
  -- ============================================
  --  LIVE SERVER (para HTML/CSS/JS puro)
  -- ============================================
  {
    "aurum77/live-server.nvim",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = function()
      require("live_server").setup({
        browser_command = vim.fn.has("win32") == 1 and "start" or "xdg-open",
        port = 3000,
      })
    end,
  },

  -- ============================================
  --  MARKDOWN PREVIEW
  -- ============================================
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_start = false
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_refresh_slow = false
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_to_cmd = true
    end,
  },
}
