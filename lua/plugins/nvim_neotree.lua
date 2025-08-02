return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  opts = {},
  config = function()
    local bindkey = require("utils.util").bind_noremap
    bindkey("n", "<leader>ee", "<cmd>Neotree reveal_force_cwd <cr>", "open file explorer")
    bindkey("n", "<leader>ec", "<cmd>Neotree close <cr>", "close file explorer")

    require("neo-tree").setup({
      close_if_last_window = false,
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = nil,
          expander_collapsed = "[+]",
          expander_expanded = "[-]",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "[-]",
          folder_open = "[+]",
          folder_empty = "[E]",
          default = "[F]",
          highlight = "NeoTreeFileIcon",
        },
        modified = {
          symbol = "[M]",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            added = "[A]",
            modified = "[M]",
            deleted = "[D]",
            renamed = "[R]",
            untracked = "[U]",
            ignored = "[I]",
            unstaged = "[US]",
            staged = "[S]",
            conflict = "[C]",
          },
        },
      },
    })
  end,
}
