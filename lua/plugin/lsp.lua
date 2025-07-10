local lspconfig = require("lspconfig")
local vim = vim

-- Configure diagnostic
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "solid",
		source = true,
		header = "",
		prefix = "",
	},
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "ℹ",
		},
	},
})

-- Define diagnostic highlight groups using Lua API
vim.api.nvim_set_hl(0, "DiagnosticFullLineError", { bg = "#3f1d1d", bold = false, italic = false, underline = false })
vim.api.nvim_set_hl(0, "DiagnosticFullLineWarn", { bg = "#3f331d", bold = false, italic = false, underline = false })

-- Create namespace for our diagnostics
local ns_id = vim.api.nvim_create_namespace("diagnostic_full_line")

-- Function to apply full-width line highlighting
local function apply_full_line_highlights()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Clear existing highlights
	vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

	-- Get all diagnostics
	local diagnostics = vim.diagnostic.get(bufnr)
	local line_diagnostics = {}

	-- Group diagnostics by line and find highest severity per line
	for _, diag in ipairs(diagnostics) do
		local line = diag.lnum
		local severity = diag.severity

		if not line_diagnostics[line] or severity < line_diagnostics[line] then
			line_diagnostics[line] = severity
		end
	end

	-- Apply highlights to each line
	for line, severity in pairs(line_diagnostics) do
		-- Choose highlight group based on severity
		local hl_group = ({
			[1] = "DiagnosticFullLineError",
			[2] = "DiagnosticFullLineWarn",
			[3] = "DiagnosticFullLineInfo",
			[4] = "DiagnosticFullLineHint",
		})[severity]

		-- Set extmark with line highlight that extends to EOL
		vim.api.nvim_buf_set_extmark(bufnr, ns_id, line, 0, {
			line_hl_group = hl_group,
			priority = 10,
		})
	end
end

-- Set up autocommands to refresh highlights
vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter", "WinScrolled" }, {
	callback = function()
		vim.schedule(apply_full_line_highlights)
	end,
})

-- Mapping diagnostics
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open diagnostic window!" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic!" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic!" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loc list for diagnostic!" })

-- Use LspAttach autocmd to only map the following keys after the language server attaches to the current buffer.
local telescope_builtin = require("telescope.builtin")
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)
		vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opts)
		vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, opts)
		vim.keymap.set("n", "go", telescope_builtin.lsp_outgoing_calls, opts)
		vim.keymap.set("n", "gb", telescope_builtin.lsp_incoming_calls, opts)
		vim.keymap.set("n", "<leader>ls", telescope_builtin.lsp_document_symbols, opts)
		vim.keymap.set("n", "<leader>lw", telescope_builtin.lsp_workspace_symbols, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
})

-- local document_hover = vim.lsp.with(vim.lsp.handlers.hover, {
-- 	border = "single", -- You can use: 'single', 'double', 'rounded', 'solid', 'shadow', 'none'
-- })
--
-- -- If you're also using signature help, you can configure it similarly
-- local document_signature_help = vim.lsp.with(vim.lsp.handlers.signature_help, {
-- 	border = "single",
-- })

local border = {
	{ "┌", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "┐", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "┘", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "└", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- Add the border on hover and on signature help popup window
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3B3F40" })

-- Configure language servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
	handlers = handlers,
})
