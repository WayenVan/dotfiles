local Hydra = require("hydra")
local hint_window = nil
local utils = require("utils.hydra")

-- color setup
local orange_hl = vim.api.nvim_get_hl(0, { name = "Debug", link = false })
local hl_mode_name, hl_surround_name = utils.generate_and_set_hl("Draw", orange_hl.fg)
local heads = {
  { "H", "<C-v>h:VBox<CR>", { desc = "←" } },
  { "J", "<C-v>j:VBox<CR>", { desc = "↓" } },
  { "K", "<C-v>k:VBox<CR>", { desc = "↑" } },
  { "L", "<C-v>l:VBox<CR>", { desc = "→" } },
  { "<C-h>", "xi<C-v>u25c4<Esc>", { desc = "◄" } }, -- mode = 'v' somehow breaks
  { "<C-j>", "xi<C-v>u25bc<Esc>", { desc = "▼" } },
  { "<C-k>", "xi<C-v>u25b2<Esc>", { desc = "▲" } },
  { "<C-l>", "xi<C-v>u25ba<Esc>", { desc = "►" } },
  { "f", ":VBox<CR>", { mode = "v", desc = "box" } },
  { "<C-c>", nil, { exit = true, desc = "exit" } },
  -- { "q", nil, { exit = true, desc = "exit" } },
}

require("which-key").add({
  { "<leader>D", icon = "", name = "Draw Diagram" },
})
Hydra({
  name = "Venn Diagram",
  config = {
    color = "pink",
    hint = false,
    invoke_on_body = true,
    on_enter = function()
      vim.wo.virtualedit = "all"
      hint_window = utils.hint_popup(" Draw", hl_mode_name, hl_surround_name, heads)
      hint_window:mount()
    end,
    on_exit = function()
      if hint_window then
        hint_window:unmount()
      end
    end,
  },
  mode = "n",
  body = "<leader>D",
  heads = heads,
})
