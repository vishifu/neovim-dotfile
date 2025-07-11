-- This file is used to setup blink.cmp for auto completion
-- https://github.com/saghen/blink.cmp

return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
  },
  config = function()
    require("blink.cmp").setup({
      snippets = { preset = "luasnip" },
      signature = { enabled = true },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "normal",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          cmdline = {
            min_keyword_length = 2,
          },
        },
      },
      keymap = {
        ["<C-f>"] = {},
        ["<cr>"] = { "accept", "fallback" },
        ["<tab>"] = { "select_next", "fallback" },
        ["<S-tab>"] = { "select_prev", "fallback" },
        ["<C-space>"] = {
          function(cmp)
            cmp.show({ providers = { "snippets" } })
          end,
        },
      },
      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },
        keymap = {
          ["<cr>"] = { "accept", "fallback" },
          ["<tab>"] = { "select_next", "fallback" },
          ["<S-tab>"] = { "select_prev", "fallback" },
          ["<C-space>"] = {
            function(cmp)
              cmp.show({ providers = { "snippets" } })
            end,
          },
        },
      },
      completion = {
        menu = {
          border = nil,
          scrolloff = 1,
          scrollbar = false,
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "kind" },
              { "source_name" },
            },
          },
          documentation = {
            window = {
              border = nil,
              scrollbar = false,
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      },
    })

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
