local vim = vim

require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = {
		-- TODO: separate LSP, Linter, Formatter
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
		border = "single",
		backdrop = 60,
	},
	log_level = vim.log.levels.ERROR,
})
