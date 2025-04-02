local dap = require("dap")
local dapui = require("dapui")

dap.set_log_level("INFO")

---@diagnostic disable-next-line: missing-fields
dapui.setup({
        icons = {
                expanded = "▾",
                collapsed = "▸",
                current_frame = "»",
        },
        layouts = {
                {
                        elements = {
                                { id = "breakpoints", size = 0.2 },
                                { id = "stacks",      size = 0.2 },
                                { id = "watches",     size = 0.4 },
                                { id = "scopes",      size = 0.2 }
                        },
                        position = "left",
                        size = 60,
                },
                {
                        elements = {
                                { id = "console", size = 0.5 },
                                { id = "repl",    size = 0.5 },
                        },
                        position = "bottom",
                        size = 10,
                },
        },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
end

require("mason-nvim-dap").setup({
        ensure_installed = { "delve" },
})

require("dap-go").setup({})
require("nvim-dap-virtual-text").setup({})


-- Setup keymaps
vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true, silent = true, desc = "DAP debug continue!" })
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor,
        { noremap = true, silent = true, desc = "DAP run to current cursor!" })
vim.keymap.set("n", "<leader>do", dap.step_over, { noremap = true, silent = true, desc = "DAP step over!" })
vim.keymap.set("n", "<leader>di", dap.step_into, { noremap = true, silent = true, desc = "DAP step into!" })
vim.keymap.set("n", "<leader>du", dap.step_out, { noremap = true, silent = true, desc = "DAP step out!" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { noremap = true, silent = true, desc = "DAP terminate" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,
        { noremap = true, silent = true, desc = "DAP toggle breakpoint!" })
vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { noremap = true, silent = true, desc = "DAP set breakpoint!" })
vim.keymap.set("n", "<leader>dE", dap.set_exception_breakpoints,
        { noremap = true, silent = true, desc = "DAP set exception breakpoint!" })
vim.keymap.set("n", "<leader>dbc", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { noremap = true, silent = true, desc = "DAP set breakpoint condition!" })
vim.keymap.set("n", "<leader>dbm", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
end, { noremap = true, silent = true, desc = "DAP breakpoint log message!" })


-- Setup signs
local dap_signs = {
        breakpoint = {
                text = "●",
                texthl = "DapBreakpoint",
                linehl = "",
                numhl = ""
        },
        breakpoint_rejected = {
                text = "○",
                texthl = "DapBreakpointRejected",
                linehl = "",
                numhl = ""
        },
        stopped = {
                text = "▶",
                texthl = "DapStopped",
                linehl = "DapStoppedLine",
                numhl = ""
        },
        logpoint = {
                text = "◆",
                texthl = "DapLogPoint",
                linehl = "",
                numhl = ""
        },
        conditional_breakpoint = {
                text = "◉",
                texthl = "DapConditionalBreakpoint",
                linehl = "",
                numhl = ""
        }
}

-- Set up sign definitions
vim.fn.sign_define("DapBreakpoint", dap_signs.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", dap_signs.breakpoint_rejected)
vim.fn.sign_define("DapStopped", dap_signs.stopped)
vim.fn.sign_define("DapLogPoint", dap_signs.logpoint)
vim.fn.sign_define("DapBreakpointCondition", dap_signs.conditional_breakpoint)

-- Set up highlight groups
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF0000" })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#FF8800" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00FF00" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#00FFFF" })
vim.api.nvim_set_hl(0, "DapConditionalBreakpoint", { fg = "#FF00FF" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#223344" })
