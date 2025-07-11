return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false, -- neo-tree will lazily load itself
	opts = {},
	config = function()
		local bindkey = require("utils.util").bind_noremap
		bindkey("n", "<leader>ee", "<cmd>Neotree reveal_force_cwd <cr>", "open file explorer")
		bindkey("n", "<leader>ec", "<cmd>Neotree close <cr>", "close file explorer")
	end,
}
