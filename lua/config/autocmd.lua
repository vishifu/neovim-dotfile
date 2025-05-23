local api = vim.api

local function augroup(name)
	return api.nvim_create_augroup(name, { clear = true })
end

api.nvim_create_autocmd("TextYankPost", {
	group = augroup("buffer_yank"),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Goto last loc when reopen buffer
api.nvim_create_autocmd("BufReadPost", {
	group = augroup("buffer_last_loc"),
	callback = function(event)
		local exclude = { "gitcommit", "NeogitCommitMessage" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = api.nvim_buf_get_mark(buf, '"')
		local lcount = api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

api.nvim_create_autocmd("BufEnter", {
	group = augroup("buffer_disable_auto_comment"),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})
