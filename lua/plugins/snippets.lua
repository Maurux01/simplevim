return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Custom snippets
      ls.add_snippets("lua", {
        s("req", {
          t("local "), i(1, "module"), t(" = require(\""), i(2, "module"), t("\")")
        }),
        s("func", {
          t("local function "), i(1, "name"), t("("), i(2), t(")"),
          t({"", "  "}), i(0),
          t({"", "end"})
        }),
      })

      ls.add_snippets("javascript", {
        s("cl", {
          t("console.log("), i(1), t(")")
        }),
        s("af", {
          t("const "), i(1, "name"), t(" = ("), i(2), t(") => {"),
          t({"", "  "}), i(0),
          t({"", "}"})
        }),
      })

      ls.add_snippets("python", {
        s("def", {
          t("def "), i(1, "name"), t("("), i(2), t("):"),
          t({"", "    "}), i(0)
        }),
        s("class", {
          t("class "), i(1, "Name"), t(":"),
          t({"", "    def __init__(self, "}), i(2), t("):"),
          t({"", "        "}), i(0)
        }),
      })
    end,
  },
}