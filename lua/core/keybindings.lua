-- Configure vanilla keybindings

local vim = vim
local mapkey = vim.keymap.set

-- navigation panel
mapkey("n", "<C-h>", "<C-w>h", { remap = true, desc = "Goto left panel" })
mapkey("n", "<C-j>", "<C-w>j", { remap = true, desc = "Goto down panel" })
mapkey("n", "<C-k>", "<C-w>k", { remap = true, desc = "Goto up panel" })
mapkey("n", "<C-l>", "<C-w>l", { remap = true, desc = "Goto right panel" })

-- split panel
mapkey("n", "<leader>vs", "<cmd>:vsplit <cr>", { remap = true, desc = "Split panel vertically" })
mapkey("n", "<leader>vh", "<cmd>:split <cr>", { remap = true, desc = "Split panel horizontally" })


-- resize panel
mapkey("n", "<C-S-h>", "<cmd>:vertical resize -2<cr>", { desc = "Minimize panel" })
mapkey("n", "<C-S-l>", "<cmd>:vertical resize +2<cr>", { desc = "Maximize panel" })

-- clear hight result
mapkey("n", "<CR>", ":noh <cr><cr>", { noremap = true, silent = true, desc = "Clear highlight result" })

-- clipboard
if vim.fn.has("unamedplus") then
	vim.opt.clipboard = "unnamed,unnamedplus"
	mapkey("n", "<leader>d", '"+d', { noremap = true })
	mapkey("n", "<leader>D", '"+D', { noremap = true })
	mapkey("v", "<leader>d", '"+d', { noremap = true })
else
	vim.opt.clipboard = "unnamed"
	mapkey("n", "<leader>d", '"*d', { noremap = true })
	mapkey("n", "<leader>D", '"*D', { noremap = true })
	mapkey("v", "<leader>d", '"*d', { noremap = true })
end
