-- Utilities for logging to file

local vim = vim
local M = {}

function M.debug_log(msg)
	local file = io.open(vim.fn.stdpath("log") .. "/nvim_debug.log", "a")
	if file then
		file:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. msg .. "\n")
		file:close()
	end
end

return M
