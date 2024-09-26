local Hydra = require("hydra")
local hint_window = nil
Hydra({
  name = "Side scroll",
  mode = "n",
  body = "Z",
  heads = {
    { "h", "5zh" },
    { "l", "5zl", { desc = "←/→" } },
    { "H", "zH" },
    { "L", "zL", { desc = "half screen ←/→" } },
    { "j", "3<c-e>" },
    { "k", "3<c-y>" },
  },
  config = {
    hint = false,
    invoke_on_body = true,
    on_enter = function()
      hint_window = require("utils.hydra").hint_popup(" Scroll", {
        { "h", "←" },
        { "l", "→" },
        { "j", "↓" },
        { "k", "↑" },
        { "H", "half screen ← " },
        { "L", "half screen →" },
        { "q", "exit" },
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
})
