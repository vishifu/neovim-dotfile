-- this file is used to configure LSP for lua

local blink = require("blink.cmp")

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".git",
    "stylua.toml",
    ".stylua.toml",
    ".luarc.json",
    ".luarc.jsonc",
  },
  settings = {
    Lua = {
      diagnostics = {
        disable = { "missing-fields" },
        globals = { "vim" },
      },
      hint = {
        enable = true,
        setType = true,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
  capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    blink.get_lsp_capabilities(),
    {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    }
  ),
}
