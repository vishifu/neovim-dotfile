-- This file use folke.lazy to manage plugins for Neovim

local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		-- print debug log and exit
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
		}, true, {})

		vim.fn.getchar()
		os.exit(1)
	end
end

-- add lazypath to runtimepath
vim.opt.rtp:prepend(lazypath)

-- setup lazy
require("lazy").setup({
	spec = {
		-- use structure of plugins for imports
		{ import = "plugins" },
	},
	checker = { enable = true },
})
