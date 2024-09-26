local Hydra = require("hydra")
local hint_window = nil
Hydra({
  name = "Side scroll",
  mode = "n",
  body = "Z",
  heads = {
    { "h", "5zh", { desc = "which_key_ignore" } },
    { "l", "5zl", { desc = "which_key_ignore" } },
    { "H", "zH", { desc = "which_key_ignore" } },
    { "L", "zL", { desc = "which_key_ignore" } },
  },
  config = {
    hint = false,
    -- invoke_on_body = true,
    on_enter = function()
      vim.wo.virtualedit = "all"
      vim.g.hydra = "draw"
      hint_window = require("utils.hydra").hint_popup(" Scroll", {
        { "h", "←" },
        { "l", "→" },
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
