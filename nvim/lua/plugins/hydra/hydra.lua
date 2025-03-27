return {
  {
    "nvimtools/hydra.nvim",
    event = "VeryLazy",
    enabled = true,
    init = function()
      _G._Hydra = {
        spawn = {},
        mode = "normal",
      }
    end,
    -- url = "https://github.com/cathyprime/hydra.nvim",
    dependencies = {
      -- "folke/snacks.nvim",
      -- "folke/lazy.nvim",
    },
    config = function(_, opts)
      vim.g.hydra_mode = nil
      require("plugins.hydra.modes.draw")
      require("plugins.hydra.modes.scroll")
      require("plugins.hydra.modes.window")
      require("plugins.hydra.modes.debug")
    end,
  },
}
