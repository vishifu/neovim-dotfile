-- This file is used to configure telescope

local function keymaps()
  local bindkey = require("utils.util").bind_noremap
  local builtin = require("telescope.builtin")

  bindkey("n", "<leader>ff", "<cmd>Telescope find_files <cr>", "Telescope find files")
  bindkey("n", "<leader>fg", "<cmd>Telescope live_grep <cr>", "Telescope live grep")
  bindkey("n", "<leader>fb", "<cmd>Telescope buffers <cr>", "Telescope list buffers")
  bindkey("n", "<leader>fh", "<cmd>Telescope help_tags <cr>", "Telescope help tags")
  bindkey("n", "<leader>fo", "<cmd>Telescope oldfiles <cr>", "Telescope old files")
  bindkey("n", "<leader>fm", "<cmd>Telescope marks <cr>", "Telescope bookmarks")
  bindkey("n", "<leader>fd", "<cmd>Telescope diagnostics <cr>", "Telescope diagnostics")
  bindkey("n", "<leader>fk", "<cmd>Telescope keymaps <cr>", "Telescope keymaps")
  bindkey("n", "<leader>fz", "<cmd>Telescope lsp_document_symbols <cr>", "Telescope LSP document symbols")
  bindkey("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
      previewer = false,
      layout_config = { width = 0.7 },
    }))
  end, "Telescope fuzzy search current buffer")
  bindkey("n", "<leader>gf", "<cmd>Telescope git_files <cr>", "Telescope git files")
  bindkey("n", "<leader>gc", "<cmd>Telescope git_commits <cr>", "Telescope git commits")
  bindkey("n", "<leader>gb", "<cmd>Telescope git_branches <cr>", "Telescope git branches")
  bindkey("n", "<leader>gs", "<cmd>Telescope git_status <cr>", "Telescope git status")
end

local function override_lsp_keymaps()
  local bindkey = require("utils.util").bind_noremap
  local builtin = require("telescope.builtin")

  bindkey("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
  bindkey("n", "gt", vim.lsp.buf.type_definition, "Goto type definition")
  bindkey("n", "gd", builtin.lsp_definitions, "Goto definition")
  bindkey("n", "gr", builtin.lsp_references, "Goto references")
  bindkey("n", "gi", builtin.lsp_implementations, "Goto implementations")
  bindkey("n", "<leader>ls", builtin.lsp_document_symbols, "Show document symbols")
  bindkey("n", "<leader>lw", builtin.lsp_workspace_symbols, "Show workspace symbols")
  bindkey("n", "K", vim.lsp.buf.hover, "Hover document")
  bindkey("n", "grn", vim.lsp.buf.rename, "Rename symbol")
  bindkey({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
end

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = require("utils.util").display_path,
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            promp_position = "top",
            preview_width = 0.5,
            result_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      winblend = 0,
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" },
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      buffer_preview_maker = require("telescope.previewers").buffer_previewer_maker,
      extensions = {
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          addtional_args = function()
            return { "--hidden" }
          end,
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")

    keymaps()
    override_lsp_keymaps()
  end,
}
