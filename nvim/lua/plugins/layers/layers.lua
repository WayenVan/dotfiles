return {
  {
    "debugloop/layers.nvim",
    lazy = false,
    init = function()
      _G.LayersManager = {
        layers = {},
        activated_layers = {},
      }
    end,
    keys = {
      {
        "<leader>D",
        function()
          LayersManager.layers["DRAW"]:activate()
        end,
        { desc = "Activate Draw Layer" },
      },
      {
        "<leader>$",
        function()
          LayersManager.layers["REPL"]:activate()
        end,
        { desc = "Activate REPL layer" },
      },
    },
    config = function()
      require("layers").setup({})
      require("plugins.layers.sublayers.draw")
      require("plugins.layers.sublayers.repl")
    end,
  },
}
