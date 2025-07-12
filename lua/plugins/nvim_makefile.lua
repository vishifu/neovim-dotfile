-- This file is used to setup for Makefile configuration

return {
  {
    "Zeioth/makeit.nvim",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    depedencies = { "stevearc/overseer.nvim" },
    config = function()
      require("makeit").setup({})
    end,
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
    config = function()
      require("overseer").setup({})
    end,
  },
}
