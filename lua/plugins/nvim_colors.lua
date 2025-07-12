return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = false
      vim.opt.cursorline = true
      vim.cmd.colorscheme("gruvbox-material")

      -- Custom highlights
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#d5c4a1" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#d5c4a1" })
    end,
  },
  {
    -- "ellisonleao/gruvbox.nvim",
    -- config = function()
    --   require("gruvbox").setup({
    --     terminal_colors = true, -- add neovim terminal colors
    --     undercurl = true,
    --     underline = true,
    --     bold = true,
    --     italic = {
    --       strings = false,
    --       emphasis = false,
    --       comments = false,
    --       operators = false,
    --       folds = true,
    --     },
    --     strikethrough = true,
    --     invert_selection = false,
    --     invert_signs = false,
    --     invert_tabline = false,
    --     inverse = true, -- invert background for search, diffs, statuslines and errors
    --     contrast = "medium", -- can be "hard", "soft" or empty string
    --     palette_overrides = {},
    --     overrides = {},
    --     dim_inactive = false,
    --     transparent_mode = false,
    --   })
    --   vim.o.background = "dark" -- or "light" for light mode
    --   vim.cmd("colorscheme gruvbox")
    -- end,
  },
  {

    "RRethy/base16-nvim",
    config = function()
      -- require("base16-colorscheme").with_config({
      --   telescope = true,
      --   indentblankline = true,
      --   notify = true,
      --   ts_rainbow = true,
      --   cmp = true,
      --   illuminate = true,
      --   dapui = true,
      -- })
      --
      -- vim.cmd([[ colorscheme base16-gruvbox-material-dark-medium ]])
      -- vim.opt.cursorline = true
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3c3836" })
    end,
  },
}
