-- This file is used to config indent

return {
  "lukas-reineke/indent-blankline.nvim",
  verison = false,
  config = function()
    require("ibl").setup({
      indent = {
        char = "│",
      },
      scope = { enabled = false },
    })
  end,
}
