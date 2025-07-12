return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      sync_install = false,
      modules = {},
      highlight = {
        enable = true,
        additionla_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "javascript",
        "lua",
        "luadoc",
        "markdown",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
        "json",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>vv",
          node_incremental = "+",
          node_decremental = "-",
          scope_incremental = false,
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { query = "@function.outer", desc = "around a function" },
            ["if"] = { query = "@function.inner", desc = "inner part of a function" },
            ["ac"] = { query = "@class.outer", desc = "around a class" },
            ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
            ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
            ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
            ["al"] = { query = "@loop.outer", desc = "around a loop" },
            ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
            ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@parameter.inner"] = "v",
            ["@function.outer"] = "v",
            ["@conditional.outer"] = "V",
            ["@loop.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
          include_surrounding_whitespace = false,
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Previous function" },
            ["[c"] = { query = "@class.outer", desc = "Previous class" },
            ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
          },
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function" },
            ["]c"] = { query = "@class.outer", desc = "Next class" },
            ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })
  end,
}
