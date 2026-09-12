-- lua/plugins/navigation.lua
-- Telescope, nvim-tree

return {
  -- ============================================
  --  TELESCOPE
  -- ============================================
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Buscar archivos" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Buscar en contenido" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Lista de buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Ayuda" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Archivos recientes" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostico" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Simbolos del documento" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status git" },
    },
    config = function()
      local telescope = require("telescope")
      -- fd/rg son binarios externos: forzar find_command con fd inexistente
      -- rompe find_files ("fd: Executable not found"). Solo se configuran
      -- si estan instalados; si no, Telescope usa su buscador por defecto
      -- y se avisa una vez por sesion.
      local has_fd = vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1
      local has_rg = vim.fn.executable("rg") == 1
      if not has_fd then
        vim.notify("simplevim: 'fd' no encontrado; find_files usara el buscador por defecto (mas lento). Instala fd: https://github.com/sharkdp/fd", vim.log.levels.WARN)
      end
      if not has_rg then
        vim.notify("simplevim: 'rg' (ripgrep) no encontrado; live_grep no funcionara. Instalalo: https://github.com/BurntSushi/ripgrep", vim.log.levels.WARN)
      end
      local fd_bin = vim.fn.executable("fd") == 1 and "fd" or "fdfind"
      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules/",
            "%.git/",
            "dist/",
            "build/",
            "%.lock",
          },
          layout_config = {
            prompt_position = "top",
            horizontal = { preview_width = 0.55 },
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            follow = false,
            -- nil = Telescope elige su propio finder (rg/fd/find)
            find_command = has_fd and { fd_bin, "--type", "f", "--hidden", "--exclude", ".git" } or nil,
          },
          live_grep = has_rg and {
            additional_args = function()
              return { "--hidden" }
            end,
          } or nil,
        },
      })
    end,
  },

  -- ============================================
  --  NVIM-TREE (file explorer)
  -- ============================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorador de archivos" },
    },
    config = function()
      local nvim_tree = require("nvim-tree")
      nvim_tree.setup({
        filters = {
          dotfiles = false,
          custom = { "^.git$" },
        },
        git = {
          ignore = false,
          enable = true,
        },
        view = {
          width = 35,
          side = "left",
          number = false,
          relativenumber = false,
        },
        renderer = {
          indent_markers = { enable = true },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_open = "",
                arrow_closed = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "●",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "◌",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        actions = {
          open_file = {
            window_picker = { enable = true },
          },
        },
      })
    end,
  },
}
