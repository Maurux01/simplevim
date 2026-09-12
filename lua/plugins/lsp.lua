-- lua/plugins/lsp.lua
-- Mason, LSP, completado, formato

return {
  -- ============================================
  --  MASON
  -- ============================================
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },

  -- ============================================
  --  MASON-LSPCONFIG + LSP
  -- ============================================
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
    },
    opts = {
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "pyright",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "bashls",
        "dockerls",
        "sqlls",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.config("html", {
        filetypes = { "html", "htmldjango" },
      })

      vim.lsp.config("emmet_ls", {
        filetypes = {
          "html", "css", "scss", "less",
          "javascriptreact", "typescriptreact", "vue", "svelte",
        },
      })

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            validate = { enable = true },
            format = { enable = true },
            schemas = require("schemastore").json.schemas(),
          },
        },
      })

      vim.lsp.config("dockerls", {
        settings = {
          docker = {
            languageserver = {
              formatter = { ignoreMultiline = true },
              linter = { hadolint = { enabled = true } },
            },
          },
        },
      })

      vim.lsp.config("sqlls", {
        cmd = { "sql-language-server", "up", "--method", "stdio" },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, silent = true, noremap = true, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Ir a definicion")
          map("n", "gD", vim.lsp.buf.declaration, "Ir a declaracion")
          map("n", "gi", vim.lsp.buf.implementation, "Ir a implementacion")
          map("n", "gr", vim.lsp.buf.references, "Referencias")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "<leader>lh", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>ld", vim.diagnostic.open_float, "Diagnostico linea")
          map({ "n", "v" }, "<leader>lf", function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end, "Formatear (Prettier/LSP)")
          map("n", "[d", vim.diagnostic.goto_prev, "Diagnostico anterior")
          map("n", "]d", vim.diagnostic.goto_next, "Diagnostico siguiente")

          -- Diagnostico en el sign column
          vim.diagnostic.config({
            virtual_text = {
              prefix = "●",
              spacing = 4,
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
              border = "rounded",
              source = "always",
              header = "",
              prefix = "",
            },
          })
        end,
      })

      -- Formato al guardar: lo maneja conform.nvim (lua/plugins/format.lua)
      -- Se elimina el BufWritePre con vim.lsp.buf.format para evitar doble
      -- formateo y la carrera de async=true (prettier primero, LSP como fallback).
    end,
  },

  -- ============================================
  --  JSON SCHEMAS (para package.json, tsconfig, etc)
  -- ============================================
  {
    "b0o/schemastore.nvim",
    lazy = true,
    ft = { "json", "jsonc" },
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
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        performance = {
          debounce = 60,
          throttle = 30,
          fetching_timeout = 200,
        },
        enabled = function()
          local buftype = vim.bo.buftype
          if buftype == "prompt" then return false end
          local filetype = vim.bo.filetype
          if filetype == "DressingInput" then return false end
          return true
        end,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
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
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            local source_names = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            }
            vim_item.menu = source_names[entry.source.name] or ""
            return vim_item
          end,
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })
    end,
  },
}
