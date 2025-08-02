return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.tabline").setup({
      show_icons = false,
      format = nil,
      tabpage_section = "left",
    })
  end,
}
