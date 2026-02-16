LayersManager.layers.WINDOW = Layers.mode.new("REPL Layer")
local window = LayersManager.layers.WINDOW
window:auto_show_help()
-- repl_layer.window.config.width = nil
window:keymaps({
  n = {
    -- scope
    {
      "+",
      "<C-w>+",
      { desc = "Increase height" },
    },
    {
      "_",
      "<C-w>-",
      { desc = "Decrease height" },
    },
    {
      ">",
      "<C-w>>",
      { desc = "Increase width" },
    },
    {
      "<",
      "<C-w><",
      { desc = "Decrease width" },
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
