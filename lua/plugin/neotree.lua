local vim = vim

require("neo-tree").setup({
	close_if_last_window = true,
	filesystem = {
		follow_current_file = {
			enable = true,
			leave_dirs_open = true,
		},
	},
})

vim.keymap.set("n", "<leader>ee", "<cmd>Neotree reveal<CR>", { desc = "Open/Close Neotree explorer!" })
vim.keymap.set("n", "<leader>ef", "<cmd>Neotree focus<CR>", { desc = "Focus on Neotree explorer!" })
vim.keymap.set("n", "<leader>ec", "<cmd>Neotree close<CR>", { desc = "Close Neotree explorer!" })
