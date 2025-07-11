return {
  "RRethy/base16-nvim",
  config = function()
    require("base16-colorscheme").with_config({
      telescope = true,
      indentblankline = true,
      notify = true,
      ts_rainbow = true,
      cmp = true,
      illuminate = true,
      dapui = true,
    })

    vim.cmd([[ colorscheme base16-gruvbox-material-dark-medium ]])
    vim.opt.cursorline = true
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3c3836" })
  end,
}
