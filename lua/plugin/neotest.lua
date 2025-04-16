require("neotest").setup({
	adapters = {
		require("neotest-go")({
			recursive_run = true,
		}),
	},
	floating = {
		border = "none",
	},
})

vim.keymap.set("n", "<leader>it", "<CMD>Neotest run<CR>", { noremap = true, desc = "Neotest run test at cursor" })
vim.keymap.set(
	"n",
	"<leader>io",
	"<CMD>Neotest output<CR>",
	{ noremap = true, desc = "Neotest output for current test" }
)
vim.keymap.set(
	"n",
	"<leader>ip",
	"<CMD>Neotest output-panel<CR>",
	{ noremap = true, desc = "Neotest open output panel" }
)
vim.keymap.set("n", "<leader>is", "<CMD>Neotest summary<CR>", { noremap = true, desc = "Neotest summary toggle" })
