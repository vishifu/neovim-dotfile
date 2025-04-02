require("mini.cursorword").setup({
        delay = 100,
})

local vim = vim
vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
                vim.api.nvim_set_hl(0, "MiniCursorWord", { underline = true, bg = nil })
                vim.api.nvim_set_hl(0, "miniCursorWordCurrent", { underline = true, bg = nil })
        end,
})
vim.cmd("doautocmd ColorScheme")
