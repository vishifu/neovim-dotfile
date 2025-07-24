-- This file is used to config Float terminal

return {
  "voldikss/vim-floaterm",
  version = false,
  config = function()
    local function keymap()
      local bindkey = require("utils.util").bind_noremap

      bindkey("n", "<C-`>", "<cmd>FloatermToggle <cr>", "Float terminal toggle")
    end

    keymap()
  end,
}
