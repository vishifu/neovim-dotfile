local mapkey = vim.keymap.set

-- navigation panel
mapkey("n", "<C-h>", "<C-w>h", { remap = true, desc = "Goto left panel" })
mapkey("n", "<C-j>", "<C-w>j", { remap = true, desc = "Goto down panel" })
mapkey("n", "<C-k>", "<C-w>k", { remap = true, desc = "Goto up panel" })
mapkey("n", "<C-l>", "<C-w>l", { remap = true, desc = "Goto right panel" })

mapkey("n", "<C-S-Right>", "<cmd>:vertical resize -2<cr>", { desc = "Minimize window" })
mapkey("n", "<C-S-Left>", "<cmd>:vertical resize +2<cr>", { desc = "Maximize window" })

-- clear hight result
mapkey("n", "<CR>", ":noh <CR><CR>", { noremap = true, silent = true, desc = "Clear highlight result" })

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
