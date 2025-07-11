-- Setup autocmd

local vim = vim

local augroup = function(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- autocmd highlight yank text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("buffer_yank"),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- autocmd cursor at the last position when leave file
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("buffer_last_loc"),
	callback = function(event)
		local exclude = { "gitcommit", "NeogitCommitMessage" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- autocmd disable comment when insert new line with "o" key
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("buffer_disable_auto_comment"),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end
})
