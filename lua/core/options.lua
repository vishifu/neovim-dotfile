-- Configuration for global options in Neovim

local opt = vim.opt

-- remap leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- show number (relative, width)
opt.nu = true
opt.rnu = true
opt.nuw = 6

-- tab width for indent
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- sensitive case
opt.smartcase = true
opt.ignorecase = true

-- swap and backup file
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- grep string
opt.hlsearch = true
opt.incsearch = true

-- offset for scroll
opt.scrolloff = 15

-- timeout for key stroke
opt.timeoutlen = 500

-- colors
opt.termguicolors = true

-- encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.updatetime = 50
opt.conceallevel = 2
opt.isfname:append("@-@")

opt.guifont = "RobotoMono Nerd Font Mono:h16"
