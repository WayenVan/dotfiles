local Hydra = require("hydra")
-- :▼etlocal ve=all
-- :setlocal ve=none
local hint_window = nil
Hydra({
  name = "Venn Diagram",
  config = {
    hint = false,
    color = "pink",
    invoke_on_body = true,
    on_enter = function()
      vim.wo.virtualedit = "all"
      vim.g.hydra = "draw"
      hint_window = require("utils.hydra").hint_popup(" Draw", {
        { "H", "←" },
        { "J", "↓" },
        { "K", "↑" },
        { "L", "→" },
        { "f", "box" },
        { "<C-c>", "exit" },
      })
      hint_window:mount()
    end,
    on_exit = function()
      vim.g.hydra = nil
      if hint_window then
        hint_window:unmount()
      end
    end,
  },
  mode = "n",
  body = "<leader>D",
  heads = {
    { "<C-h>", "xi<C-v>u25c4<Esc>" }, -- mode = 'v' somehow breaks
    { "<C-j>", "xi<C-v>u25bc<Esc>" },
    { "<C-k>", "xi<C-v>u25b2<Esc>" },
    { "<C-l>", "xi<C-v>u25ba<Esc>" },
    { "H", "<C-v>h:VBox<CR>" },
    { "J", "<C-v>j:VBox<CR>" },
    { "K", "<C-v>k:VBox<CR>" },
    { "L", "<C-v>l:VBox<CR>" },
    { "f", ":VBox<CR>", { mode = "v" } },
    { "<C-c>", nil, { exit = true } },
  },
})
