return {
  {
    "nvimtools/hydra.nvim",
    config = function()
      require("plugins.hydra.modes.draw")
      require("plugins.hydra.modes.scroll")
      require("plugins.hydra.modes.window")
    end,
  },
}
