LayersManager.layers.WINDOW = Layers.mode.new("REPL Layer")
local window = LayersManager.layers.WINDOW
window:auto_show_help()
-- repl_layer.window.config.width = nil
window:keymaps({
  n = {
    -- scope
    {
      "h",
      function()
        require("smart-splits").resize_left()
      end,
      { desc = "resize left" },
    },
    {
      "l",
      function()
        require("smart-splits").resize_right()
      end,
      { desc = "resize right" },
    },
    {
      "j",
      function()
        require("smart-splits").resize_down()
      end,
      { desc = "resize down" },
    },
    {
      "k",
      function()
        require("smart-splits").resize_up()
      end,
      { desc = "resize up" },
    },
    {
      "q",
      function()
        LayersManager:deactivate("WINDOW")
      end,
      { desc = "Exit" },
    },
    {
      "<Esc>",
      function()
        LayersManager:deactivate("WINDOW")
      end,
      { desc = "Exit" },
    },
    {
      "<M-q>",
      function()
        LayersManager:deactivate("WINDOW")
      end,
      { desc = "Exit" },
    },
  },
})
