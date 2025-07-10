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

vim.lsp.set_log_level("off")
--vim.lsp.set_log_level("error")
