return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.tabline").setup({
			show_icons = true,
			format = nil,
			tabpage_section = "left",
		})
	end
}
