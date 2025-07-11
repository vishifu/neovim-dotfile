-- Utilities functions for config dotfile

local M = {}

-- local function to create a buffer opts noremap for keymap
local function bufopts(bufnr, desc, nowait)
	-- in default if `nowait` is nil it will be true, otherwise it can be true/false
	nowait = (nowait ~= nil) and nowait or true
	return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = nowait }
end

-- local function to create a opts noremap for keymap
local function opts(desc, nowait)
	nowait = (nowait ~= nil) and nowait or true
	return { desc = desc, noremap = true, silent = true, nowait = nowait }
end

-- bindings noremap
function M.bind_noremap(mode, lhs, rhs, desc)
	local opts = opts(desc, true)
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- binding noremap into buffer
function M.bind_buf_noremap(mode, lhs, rhs, bufnr, desc)
	local opts = bufopts(bufnr, desc, true)
	vim.keymap.set(mode, lhs, rhs, opts)
end

function M.debug_log(msg)
	local file = io.open(vim.fn.stdpath("log") .. "./nvim_debug.log", "a")
	if file then
		file:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. msg .. "\n")
		file:close()
	end
end

return M
