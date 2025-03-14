return {
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
    enabled = true,
    url = "https://github.com/cathyprime/hydra.nvim",
    dependencies = {
      -- "folke/snacks.nvim",
      -- "folke/lazy.nvim",
    },
    config = function()
      require("plugins.hydra.modes.draw")
      require("plugins.hydra.modes.scroll")
      require("plugins.hydra.modes.window")
    end,
  },
}
