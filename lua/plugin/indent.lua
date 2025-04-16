--vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

require("ufo").setup({
	provider_selector = function(bufnr, ft, bt)
		return { "treesitter", "indent" }
	end,
})

require("ibl").setup({
	indent = {
		char = "¦",
	},
	scope = { enabled = false },
})
