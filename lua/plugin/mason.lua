require("mason").setup({})

---@diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"gopls",
		"clangd",
		"sqlls",
		"bashls",
		"pyright",
	},
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
