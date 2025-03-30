LayersManager.layers.WINDOW = Layers.mode.new("REPL Layer")
local window = LayersManager.layers.WINDOW
window:auto_show_help()
-- repl_layer.window.config.width = nil
window:add_hook(function(activate)
  local idx = nil
  if activate then
    --manaully load the package
    table.insert(LayersManager.activated_layers, "WINDOW")
    idx = #LayersManager.activated_layers
    return
  end

  if not activate then
    table.remove(LayersManager.activated_layers, idx)
    idx = nil
  end
end)
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
        window:deactivate()
      end,
      { desc = "Exit" },
    },
    {
      "<Esc>",
      function()
        window:deactivate()
      end,
      { desc = "Exit" },
    },
    {
      "<C-q>",
      function()
        window:deactivate()
      end,
      { desc = "Exit" },
    },
  },
})
