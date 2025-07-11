-- This file is used to configure Spectre, that is used for searchs and replacments
-- https://github.com/nvim-pack/nvim-spectre

local function keymaps()
  local bindkey = require("utils.util").bind_noremap

  bindkey("n", "<leader>S", "<cmd>lua require('spectre').toggle() <cr>", "Spectre toggle")
  bindkey(
    "n",
    "<leader>sw",
    "<cmd>lua require('spectre').open_visual({select_word = true}) <cr>",
    "Spectre search current word"
  )
  bindkey("v", "<leader>sw", "<cmd>lua require('spectre').open_visual() <cr>", "Spectre search current word")
  bindkey(
    "n",
    "<leader>sp",
    "<cmd>lua require('spectre').open_file_search({select_word = true}) <cr>",
    "Spectre search on current file"
  )
end

return {
  "nvim-pack/nvim-spectre",
  version = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    keymaps()

    require("spectre").setup({})
  end,
}
