return {
  "vhyrro/luarocks.nvim",
  priority = 1000, -- Very high priority is required
  opts = {
    rocks = { "fzy", "pathlib.nvim ~> 1.0" }, -- Specify LuaRocks packages to install
  },
}
