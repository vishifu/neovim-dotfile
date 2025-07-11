-- Fidget.nvim setup for Lazy.nvim

return {
  "j-hui/fidget.nvim",
  opts = {},
  config = function()
    require("fidget").setup({
      -- Options for fidget
      progress = {
        poll_rate = 0, -- How often to poll for progress messages
        suppress_on_insert = false, -- Suppress new messages while in insert mode
        ignore_done_already = false, -- Ignore new tasks that are already complete
        ignore_empty_message = false, -- Ignore new tasks that don't contain a message
        clear_on_detach = true, -- Clear notification group when LSP server detaches
        notification_group = function(msg)
          return msg.lsp_server.name
        end,
        ignore = {}, -- List of LSP servers to ignore
        display = {
          render_limit = 16, -- How many LSP messages to show at once
          done_ttl = 3, -- How long a message should persist after completion
          done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
          done_style = "Constant", -- Highlight group for completed LSP tasks
          progress_ttl = math.huge, -- How long a message should persist when in progress
          progress_icon = { pattern = "dots", period = 1 },
          progress_style = "WarningMsg",
          group_style = "Title", -- Highlight group for group name
          icon_style = "Question", -- Highlight group for group icons
          priority = 30, -- Ordering priority for LSP notification group
          skip_history = true, -- Whether progress notifications should be omitted from history
          format_message = require("fidget.progress.display").default_format_message,
          format_annote = function(msg)
            return msg.title
          end,
          format_group_name = function(group)
            return tostring(group)
          end,
          overrides = { -- Override options from the default notification config
            rust_analyzer = { name = "rust-analyzer" },
          },
        },
        lsp = {
          progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
        },
      },
      notification = {
        poll_rate = 10, -- How frequently to update and render notifications
        filter = vim.log.levels.INFO, -- Minimum notifications level
        history_size = 128, -- Number of removed messages to retain in history
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget
        configs = { -- How to configure notification groups when instantiated
          default = require("fidget.notification").default_config,
        },
        redirect = function(msg, level, opts)
          if opts and opts.on_open then
            return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
          end
        end,
        view = {
          stack_upwards = true, -- Display notification items from bottom to top
          icon_separator = " ", -- Separator between group name and icon
          group_separator = "---", -- Separator between notification groups
          group_separator_hl = "Comment",
          render_message = function(msg, cnt)
            return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
          end,
        },
        window = {
          normal_hl = "Text", -- Base highlight group in the notification window
          winblend = 0, -- Background color opacity in the notification window
          border = "none", -- Border around the notification window
          zindex = 45, -- Stacking priority of the notification window
          max_width = 0, -- Maximum width of the notification window
          max_height = 0, -- Maximum height of the notification window
          x_padding = 0, -- Padding from right edge of window boundary
          y_padding = 0, -- Padding from bottom edge of window boundary
          align = "bottom", -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
        },
      },
      logger = {
        level = vim.log.levels.WARN, -- Minimum logging level
        float_precision = 0.01, -- Limit the number of decimals displayed for floats
        path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("log")),
      },
    })

    -- Test notification after setup
    vim.defer_fn(function()
      vim.notify("Fidget is working!", vim.log.levels.INFO, { title = "Fidget Test" })
    end, 1000)
  end,
}
