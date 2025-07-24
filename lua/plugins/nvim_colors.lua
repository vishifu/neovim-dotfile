return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = false
      vim.g.gruvbox_material_background = "soft"
      vim.g.gruvbox_better_performance = 1
      vim.opt.cursorline = true
      vim.cmd.colorscheme("gruvbox-material")

      -- Custom highlights
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#d5c4a1" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#d5c4a1" })

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
        pattern = "gruvbox-material",
        callback = function()
          local config = vim.fn["gruvbox_material#get_configuration"]()
          local palette =
            vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
          local set_hl = vim.fn["gruvbox_material#highlight"]

          set_hl("Search", palette.none, palette.bg_visual_yellow)
          set_hl("IncSearch", palette.none, palette.bg_visual_red)
        end,
      })
    end,
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
  {
    "vishifu/darcula-dark.nvim",
    config = function()
      -- require("darcula").setup({
      --   opt = {
      --     integrations = {
      --       telescope = false,
      --       lualine = true,
      --       lsp_semantics_token = true,
      --       nvim_cmp = true,
      --       dap_nvim = true,
      --     },
      --   },
      -- })
      --
      -- vim.opt.cursorline = true
    end,
  },
}
