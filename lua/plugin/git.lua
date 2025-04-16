require("gitsigns").setup()
require("diffview").setup()

require("telescope").load_extension("lazygit")

-- Set this before the plugin loads
vim.g.lazygit_floating_window_border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
vim.g.lazygit_floating_window_winblend = 0
