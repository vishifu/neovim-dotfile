return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer", keyword_length = 3 },
				{ name = "path", keyword_length = 3 },
			},
			preselect = cmp.PreselectMode.None,
			mapping = {
				["<cr>"] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Replace,
				}),
				["<tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end,
				["<S-tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
				["<C-e>"] = cmp.mapping.abort(),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, item)
					item.kind = string.format("%s", item.kind)
					item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						path = "[Path]",
					})[entry.source.name]

					return item
				end,
			},
		})
	end,
}
