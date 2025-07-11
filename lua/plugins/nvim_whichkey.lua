return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
    },
    desc = "buffer local keymap",
  },
  opts = {
    delay = 300,
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>e", group = "explorer" },
        { "<leader>f", group = "Telescope find" },
        { "<leader>g", group = "Telescope git" },
      },
    },
  },
}
