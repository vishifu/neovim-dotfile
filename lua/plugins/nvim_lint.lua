-- This file is used to config lint for LSP

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Configure linters by filetype (using Mason)
    lint.linters_by_ft = {
      lua = "luacheck",
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    --   group = lint_augroup,
    --   callback = function()
    --     local linters = lint.linters_by_ft[vim.bo.filetype]
    --     if linters and #linters > 0 then
    --       lint.try_lint()
    --     end
    --   end,
    -- })

    -- Manual linting command
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
      vim.notify("Linting ...", vim.log.levels.INFO, { title = "nvim-lint" })
    end, { desc = "Trigger linting current buffer" })

    vim.keymap.set("n", "<leader>li", function()
      local linters = lint.linters_by_ft[vim.bo.filetype] or {}
      if #linters == 0 then
        print("No linters configured for filetype: " .. vim.bo.filetype)
      else
        print("Linter for " .. vim.bo.filetype .. ":" .. table.concat(linters, ","))
      end
    end, { desc = "Show available linters for current filetype" })
  end,
}
