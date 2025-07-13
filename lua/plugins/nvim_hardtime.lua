return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {},
  config = function()
    -- require("hardtime").setup({
    --   max_time = 100, -- maximum time (in ms) to consider key presses as repeated
    --   max_count = 5, -- maximum count of repeatation in max_time period
    -- })
  end,
}
