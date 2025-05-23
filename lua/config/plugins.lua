local vim = vim

vim.cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
	-- Packer manage itself
	use("wbthomason/packer.nvim")

	-- Format file
	use({ "stevearc/conform.nvim" })

	-- Colors
	use("sainnhe/sonokai")
	use({ "projekt0n/github-nvim-theme" })
	use({
		"rockyzhang24/arctic.nvim",
		branch = "v2",
		requires = {
			"rktjmp/lush.nvim",
		},
	})
	use("ayu-theme/ayu-vim")
	use("doums/darcula")
	use({
		"vishifu/darcula-dark.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	})
	use({
		"briones-gabriel/darcula-solid.nvim",
		dependencies = {
			"rktjmp/lush.nvim",
		},
	})
	use("ellisonleao/gruvbox.nvim")

	-- Indent
	use({
		"kevinhwang91/nvim-ufo",
		requires = {
			"kevinhwang91/promise-async",
		},
	})
	use("lukas-reineke/indent-blankline.nvim")

	-- Status line, buffer line
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use({
		"akinsho/bufferline.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use("echasnovski/mini.tabline")
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- File explorer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	})

	-- Notify, autopairs
	use("echasnovski/mini.notify")
	use("echasnovski/mini.pairs")
	use("echasnovski/mini.surround")
	use("echasnovski/mini.cursorword")
	use("echasnovski/mini.indentscope")
	use("j-hui/fidget.nvim")

	-- Helper
	use({
		"folke/noice.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
		},
	})
	use("folke/which-key.nvim")

	-- Languages, LSP, ...
	use("mason-org/mason.nvim")
	use("mason-org/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("MysticalDevil/inlay-hints.nvim")

	-- Autocomplete
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	-- Telescope
	use({
		"junegunn/fzf",
		run = ":call fzf#install()",
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-dap.nvim",
		},
	})

	-- DAP
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
	})

	use("leoluz/nvim-dap-go")
	use("julianolf/nvim-dap-lldb")

	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
		},
	})

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("sindrets/diffview.nvim")
	use("kdheepak/lazygit.nvim", {
		requires = { "nvim-lua/plenary.nvim" },
	})

	use("stevearc/overseer.nvim")
	use("Zeioth/makeit.nvim", {
		requires = { "stevearc/overseer.nvim" },
	})
end)
