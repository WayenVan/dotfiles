return {
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        "LazyVim",
        { path = "toggleterm.nvim", mods = { "toggleterm" } },
        { path = "plenary.nvim", mods = { "plenary" } },
        { path = "noice.nvim", mods = { "noice" } },
        { path = "LuaSnip", mods = { "luasnip" } },
        { path = "nvim-dap", mods = { "dap" } },
        { path = "neo-tree.nvim" },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    opts = function(_, opts)
      local config_path = vim.fn.stdpath("config")
      table.insert(opts.library, { path = config_path })
    end,
  },
}
