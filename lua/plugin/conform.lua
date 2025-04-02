local vim = vim

require("conform").setup({})

vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
                require("conform").format({ bufnr = args.buf })
        end
})

vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
        })
end, { desc = "Format file or a range of line!" })
