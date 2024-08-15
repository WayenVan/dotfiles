return {
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "toggleterm.nvim" },
        { path = "planery.nvim" },
        { path = "noice.nvim" },
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
