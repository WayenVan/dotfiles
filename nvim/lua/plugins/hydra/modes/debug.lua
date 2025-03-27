local Hydra = require("hydra")
local heads = {
  {
    "<localleader>S",
    function()
      local w = require("dap.ui.widgets")
      -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
      w.centered_float(w.sessions)
    end,
    { desc = "Dap Sessions" },
  },
  {
    "<localleader>s",
    function()
      local w = require("dap.ui.widgets")
      -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
      w.centered_float(w.scopes)
    end,
    { desc = "Dap Scopes" },
  },
  { "<localleader>R", "<cmd>lua require('dap').restart()<cr>", { desc = "Restart" } },
  { "<localleader><leader>", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step Over" } },
  { "<C-q>", nil, { exit = true, desc = "exit" } },
  -- { "q", nil, { exit = true, desc = "exit" } },
}

-- require("which-key").add({
--   { "<leader>W", icon = " ", name = "Window mode" },
-- })

_G._Hydra.spawn["debug"] = function()
  local h = Hydra({
    name = "Debug",
    config = {
      hint = false,
      color = "pink",
      invoke_on_body = true,
      on_enter = function()
        vim.g.hydra_mode = "debug"
        vim.wo.virtualedit = "all"
      end,
      on_exit = function()
        vim.g.hydra_mode = nil
      end,
    },
    mode = "n",
    body = "<leader>Q",
    heads = heads,
  })
  h:activate()
end
