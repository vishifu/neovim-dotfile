-- Assign global vim vars
local vim = vim
local opt = vim.opt

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- number
opt.nu = true
opt.rnu = true
opt.nuw = 6

-- tab, indent
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- sensitive case
opt.smartcase = true
opt.ignorecase = true

-- backup, swapfile
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undoir"

-- search
opt.hlsearch = true
opt.incsearch = true

opt.scrolloff = 15

opt.termguicolors = true

opt.updatetime = 50
opt.conceallevel = 2
opt.isfname:append("@-@")

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.timeoutlen = 500
