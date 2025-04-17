LayersManager.layers.DRAW = Layers.mode.new("Draw Layer")
local draw_layer = LayersManager.layers.DRAW
draw_layer:auto_show_help()
draw_layer:keymaps({
  n = {
    { "H", "<C-v>h:VBox<CR>", { desc = "←" } },
    { "J", "<C-v>j:VBox<CR>", { desc = "↓" } },
    { "K", "<C-v>k:VBox<CR>", { desc = "↑" } },
    { "L", "<C-v>l:VBox<CR>", { desc = "→" } },
    { "<C-h>", "xi<C-v>u25c4<Esc>", { desc = "◄" } }, -- mode = 'v' somehow breaks
    { "<C-j>", "xi<C-v>u25bc<Esc>", { desc = "▼" } },
    { "<C-k>", "xi<C-v>u25b2<Esc>", { desc = "▲" } },
    { "<C-l>", "xi<C-v>u25ba<Esc>", { desc = "►" } },
    {
      "<C-q>",
      function()
        LayersManager:deactivate("DRAW")
      end,
      { desc = "exit" },
    },
    {
      "q",
      function()
        LayersManager:deactivate("DRAW")
      end,
      { desc = "exit" },
    },
  },
  v = {
    { "f", ":VBox<CR>", { desc = "box" } },
  },
})
