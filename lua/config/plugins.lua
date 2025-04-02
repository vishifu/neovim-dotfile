local vim = vim

vim.cmd [[packadd packer.nvim]]
require("packer").startup(function(use)
        -- Packer manage itself
        use "wbthomason/packer.nvim"

        -- Format file
        use({"stevearc/conform.nvim"})

        -- Colors, schemes
        use("sainnhe/sonokai")

        -- Status line, buffer line
        use({
                "nvim-lualine/lualine.nvim",
                requires = {
                        "nvim-tree/nvim-web-devicons",
                }
        })
        use({
                "akinsho/bufferline.nvim",
                requires = {
                        "nvim-tree/nvim-web-devicons",
                }
        })
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

        -- Helper
        use({
                "folke/noice.nvim",
                requires = {
                        "MunifTanjim/nui.nvim",
                },
        })
        use("folke/which-key.nvim")

        -- Languages, LSP, ...
        use("williamboman/mason.nvim")
        use("williamboman/mason-lspconfig.nvim")
        use("neovim/nvim-lspconfig")

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
                run = ":call fzf#install()"
        })
        use({
                "nvim-telescope/telescope.nvim",
                requires = {
                        {
                                "nvim-telescope/telescope-fzf-native.nvim",
                                run = "make"
                        },
                        "nvim-telescope/telescope-live-grep-args.nvim",
                        "nvim-telescope/telescope-ui-select.nvim",
                        "nvim-telescope/telescope-dap.nvim"
                }
        })

        -- DAP
        use({
                "mfussenegger/nvim-dap",
                requires = {
                        "rcarriga/nvim-dap-ui",
                        "nvim-neotest/nvim-nio",
                        "theHamsta/nvim-dap-virtual-text",
                        "jay-babu/mason-nvim-dap.nvim"
                }
        })
        use("leoluz/nvim-dap-go")

end)
