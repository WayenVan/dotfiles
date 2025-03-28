local Hydra = require("hydra")
local heads = {
  {
    "<localleader>S",
    function()
      local w = require("dap.ui.widgets")
      -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
      w.centered_float(w.sessions, {})
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
  {
    "<localleader>t",
    function()
      require("dap").terminate()
    end,
    { desc = "Toggle Breakpoint" },
  },
  {
    "<localleader>r",
    function()
      require("dap").restart()
    end,
    { desc = "Restart" },
  },
  {
    "<localleader>c",
    function()
      require("dap").continue()
    end,
    { desc = "Continue" },
  },
  {
    "<localleader><localleader>",
    function()
      require("dap").step_over()
    end,
    { desc = "Step Over" },
  },
  {
    "<localleader>o",
    function()
      require("dap").step_over()
    end,
    { desc = "Step Over" },
  },
  {
    "<localleader>e",
    function()
      require("dapui").eval()
    end,
    { desc = "Add expression" },
  },
  {
    "<localleader>v",
    function()
      require("dap.ui.widgets").hover(nil, { border = "single" })
    end,
    { desc = "Dap Evaluate" },
  },
  { "<C-q>", nil, { exit = true, desc = "exit" } },
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
