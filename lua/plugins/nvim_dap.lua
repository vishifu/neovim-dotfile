-- This file is used to configure DAP (debugger)

return {
  "mfussenegger/nvim-dap",
  version = false,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "julianolf/nvim-dap-lldb",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup virtual text to show variable values inline
    require("nvim-dap-virtual-text").setup()

    -- Setup language dap
    require("dap-lldb").setup({})

    -- Dap UI setup
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
      layouts = {
        {
          elements = {
            { id = "breakpoints", size = 0.2 },
            { id = "stacks", size = 0.2 },
            { id = "watches", size = 0.4 },
            { id = "scopes", size = 0.2 },
          },
          position = "left",
          size = 60,
        },
        {
          elements = {
            { id = "console", size = 0.5 },
            { id = "repl", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    local function setup_dap_signs()
      -- Setup signs
      local dap_signs = {
        breakpoint = {
          text = "●",
          texthl = "DapBreakpoint",
          linehl = "",
          numhl = "",
        },
        breakpoint_rejected = {
          text = "○",
          texthl = "DapBreakpointRejected",
          linehl = "",
          numhl = "",
        },
        stopped = {
          text = "▶",
          texthl = "DapStopped",
          linehl = "DapStoppedLine",
          numhl = "",
        },
        logpoint = {
          text = "◆",
          texthl = "DapLogPoint",
          linehl = "",
          numhl = "",
        },
        conditional_breakpoint = {
          text = "◉",
          texthl = "DapConditionalBreakpoint",
          linehl = "",
          numhl = "",
        },
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
    end

    local function setup_dap_keymap()
      local bindkey = require("utils.util").bind_noremap

      bindkey("n", "<F5>", dap.continue, "DAP continue")
      bindkey("n", "<F10>", dap.step_over, "DAP step over")
      bindkey("n", "<F11>", dap.step_into, "DAP step into")
      bindkey("n", "<F8>", dap.step_out, "DAP step out")
      bindkey("n", "<leader>dt", dap.terminate, "DAP terminate")
      bindkey("n", "<leader>db", dap.toggle_breakpoint, "DAP toggle breakpoint")
      bindkey("n", "<leader>dE", dap.set_exception_breakpoints, "DAP set exception breakpoint")
      bindkey("n", "<leader>dbc", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, "DAP set breakpoint condition!")
      bindkey("n", "<leader>dbm", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
      end, "DAP breakpoint log message!")
      bindkey("n", "<leader>di", function()
        require("dap.ui.widgets").hover()
      end, "Dap variables")
      bindkey("n", "<leader>df", "<cmd>Telescope dap frames<cr>", "List frames")
      bindkey("n", "<leader>dh", "<cmd>Telescope dap commands<cr>", "List commands")
    end

    setup_dap_signs()
    setup_dap_keymap()
  end,
}
