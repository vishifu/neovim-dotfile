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
	capabilities = vim.lsp.protocol.make_client_capabilities(),
}
