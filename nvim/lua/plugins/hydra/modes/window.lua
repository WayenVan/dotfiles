local Hydra = require("hydra")
local hint_window = nil
local utils = require("utils.hydra")

-- color setup
-- local green_hl = vim.api.nvim_get_hl(0, { name = "Character", link = false })
local hl_mode_name, hl_surround_name = utils.generate_and_set_hl("Window", "#63b892")
local heads = {
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
  { "<C-c>", nil, { exit = true, desc = "exit" } },
  { "q", nil, { exit = true, desc = "exit" } },
}

_G._Hydra.spawn["window"] = function()
  Hydra({
    name = "Window",
    config = {
      hint = false,
      color = "pink",
      invoke_on_body = true,
      on_enter = function()
        vim.g.hydra_mode = "window"
        hint_window = utils.hint_popup(" Win", hl_mode_name, hl_surround_name, heads)
        hint_window:mount()
      end,
      on_exit = function()
        vim.g.hydra_mode = nil
        if hint_window then
          hint_window:unmount()
        end
      end,
    },
    mode = "n",
    body = "<leader>W",
    heads = heads,
  }):activate()
end
