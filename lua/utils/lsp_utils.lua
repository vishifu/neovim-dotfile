-- Utilities for LSP
-- key bindings for lsp attachs

local vim = vim
local M = {}

local keybinds = function(mode, lhs, rhs, bufopts, desc)
	local opts = bufopts or {}
	if desc then
		opts.desc = desc
	end
	vim.keymap.set(mode, lhs, rhs, opts)
end

function M.on_attach(client, bufnr)
	local bufopts = { silent = true, buffer = bufnr }
	local telescope_builtin = require("telescope.builtin")

	keybinds("n", "gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
	keybinds("n", "gd", telescope_builtin.lsp_definitions, bufopts, "Go to definition")
	keybinds("n", "gt", vim.lsp.buf.type_definition, bufopts, "Go to type difinition")
	keybinds("n", "gr", telescope_builtin.lsp_references, bufopts, "Go to references")
	keybinds("n", "gi", telescope_builtin.lsp_implementations, bufopts, "Go to implementations")
	keybinds("n", "go", telescope_builtin.lsp_outgoing_calls, bufopts, "Go to outgoing calls")
	keybinds("n", "gb", telescope_builtin.lsp_incoming_calls, bufopts, "Go to incomming calls")
	keybinds("n", "<leader>ls", telescope_builtin.lsp_document_symbols, bufopts, "Go to document symbols")
	keybinds("n", "<leader>lw", telescope_builtin.lsp_workspace_symbols, bufopts, "Go to workspace symbols")
	keybinds("n", "K", vim.lsp.buf.hover, bufopts, "Hover show documentation")
	keybinds("n", "grn", vim.lsp.buf.rename, bufopts, "Rename symbol")
	keybinds({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts, "Code actions")
	keybinds({ "n", "v" }, "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts, "Format file")
end

return M
