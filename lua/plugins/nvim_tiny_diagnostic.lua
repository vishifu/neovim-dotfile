return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "classic",
			transparent_bg = false,
			transparent_cursorline = false,
			blend = { factor = 0.22 },
			hi = {
				error = "DiagnosticError",
				warn = "DiagnosticWarn",
				info = "DiagnosticInfo",
				hint = "DiagnosticHint",
				arrow = "NonText",
				-- background color for diagnostics
				backgound = "CursorLine",
				-- color blending option for diagnostic background
				mixing_color = "None",
			},
			options = {
				-- display the source of the diagnostic (e.g. pyright, lua_ls, ...)
				show_source = {
					enabled = false,
					if_many = false,
				},
				-- use icons defined in the diagnostic configuration
				use_icon_from_diagnostic = true,
				-- set the arrow icon to the same color as first diagnostic severity
				use_arrow_to_diag_color = false,
				-- add messages to diagnostic when multiple diagnostic are enabled
				add_messages = true,
				-- time (in ms) to throttle updates while moving the cursor,
				-- increasing this value for better performance if feel slow.
				throttle = 20,
				-- minimum message length before wrapping to a new line
				softwrap = 30,
				multilines = {
					enabled = false,
					always_show = false,
					trim_whitespaces = false,
					tabstop = 4,
				},
				show_all_diags_on_cursorline = false,
				enable_on_insert = false,
				enable_on_select = false,
				overflow = {
					mode = "wrap",
					padding = 0,
				},
				break_line = {
					enabled = false,
					after = 30,
				},
				format = nil,
				virt_texts = {
					priority = 2048,
				},
				severity = {
					vim.diagnostic.severity.ERROR,
					vim.diagnostic.severity.WARN,
					vim.diagnostic.severity.INFO,
					vim.diagnostic.severity.HINT,
				},
				overwrite_events = nil,
			},
			disabled_ft = {},
		})
	end,
}
