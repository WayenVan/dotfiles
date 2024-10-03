local Hydra = require("hydra")
local utils = require("utils.hydra")
local blue_hl = vim.api.nvim_get_hl(0, { name = "Blue", link = false })
local hl_mode_name, hl_surround_name = utils.generate_and_set_hl("Scroll", blue_hl.fg)
local hint_window = nil
local heads = {
  { "h", "5zh" },
  { "l", "5zl", { desc = "←/→" } },
  { "H", "zH" },
  { "L", "zL", { desc = "half screen ←/→" } },
  { "j", "3<c-e>M" },
  { "k", "3<c-y>M", { desc = "↓/↑" } },
  { "J", "6<c-e>M" },
  { "K", "6<c-y>M", { desc = "longer ↓/↑" } },
  -- { "j", "3jzz" },
  -- { "k", "3kzz", { desc = "↓/↑" } },
  { "<C-c>", nil, { exit = true }, { desc = "exit" } },
}

require("which-key").add({
  { "<leader>Z", icon = "", name = "Scroll mode" },
})
Hydra({
  name = "Side scroll",
  mode = "n",
  body = "<leader>Z",
  heads = heads,
  config = {
    hint = false,
    invoke_on_body = true,
    color = "pink",
    on_enter = function()
      -- hint_window = require("utils.hydra").hint_popup(" Scroll", hl_mode_name, hl_surround_name, {
      --   { "h", "←" },
      --   { "l", "→" },
      --   { "j", "↓" },
      --   { "k", "↑" },
      --   { "H", "half screen ← " },
      --   { "L", "half screen →" },
      --   { "q", "exit" },
      -- })
      hint_window = require("utils.hydra").hint_popup(" Scroll", hl_mode_name, hl_surround_name, heads)
      hint_window:mount()
      vim.cmd([[normal! M]])
    end,
    on_exit = function()
      vim.g.hydra = nil
      if hint_window then
        hint_window:unmount()
      end
    end,
  },
})
