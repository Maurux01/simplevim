-- lua/plugins/format.lua
-- Prettier / Prettierd via conform.nvim (HTML, CSS, JS, TS, JSON, etc.)
-- El LSP queda como fallback para python, lua, bash, sql, docker...

return {
  -- Asegura que prettier/prettierd esten instalados en Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "prettier", "prettierd" },
      auto_update = false,
      run_on_start = true,
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Formatear (Prettier/LSP)",
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(_bufnr)
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        less = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        svelte = { "prettierd", "prettier", stop_after_first = true },
        -- python, lua, bash, sql, dockerfile, htmldjango: usan LSP via fallback
      },
    },
  },
}
