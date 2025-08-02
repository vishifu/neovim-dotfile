return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      -- Lua
      lua = { "stylua" },
      cpp = { "clang-format" },
    },
    format_on_save = { timeout_ms = 500 },
    default_format_options = {
      lsp_format = "fallback",
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    log_level = vim.log.levels.ERROR,
  },
}
