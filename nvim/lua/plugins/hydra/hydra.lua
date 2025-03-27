return {
  {
    "nvimtools/hydra.nvim",
    enabled = true,
    init = function()
      _G._Hydra = {
        spawn = {},
        modes = {},
      }
      vim.g.hydra_mode = nil
    end,
    keys = {
      { "<leader>Q", "<cmd>lua _Hydra.spawn.debug()<CR>", desc = "Debug mode" },
      { "<leader>D", "<cmd>lua _Hydra.spawn.draw()<CR>", desc = "Draw mode" },
      { "<leader>W", "<cmd>lua _Hydra.spawn.window()<CR>", desc = "Window mode" },
    },
    -- url = "https://github.com/cathyprime/hydra.nvim",
    dependencies = {
      -- "folke/snacks.nvim",
      -- "folke/lazy.nvim",
    },
    config = function(_, opts)
      vim.g.hydra_mode = nil
      require("plugins.hydra.modes.draw")
      -- require("plugins.hydra.modes.scroll")
      require("plugins.hydra.modes.window")
      require("plugins.hydra.modes.debug")
    end,
  },
}
