local vim = vim

local use_sonokai_theme = function()
	vim.g.sonokai_enable_italic = 0
	vim.g.sonokai_disable_italic_comment = 1
	vim.cmd.colorscheme("sonokai")
end

local use_arctic_theme = function()
	vim.cmd.colorscheme("arctic")
end

local use_ayu_theme = function()
	vim.g.ayucolor = "mirage"
	vim.cmd.colorscheme("ayu")
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFFFFF" })
end

local use_darcula_theme = function()
	vim.g.darcula_enable_italics = 0
	require("darcula").setup({
		opt = {
			integrations = {
				telescope = false,
				lualine = true,
				lsp_semantics_token = true,
				nvim_cmp = true,
				dap_nvim = true,
			},
		},
	})

	vim.cmd.colorscheme("darcula-dark")
end

local use_darcula_solid_theme = function()
	vim.cmd.colorscheme("darcula-solid")
end

local use_gruvbox = function()
	require("gruvbox").setup({
		transparent_mode = true,
	})

	vim.cmd.colorscheme("gruvbox")
end

use_gruvbox()
