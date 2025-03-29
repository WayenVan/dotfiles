local submode = require("submode")
-- debug submode
submode.create("Debug", {
  mode = "n",
  enter = "<leader>!",
  leave = { "<C-q>" },
  default = function(register)
    -- scope
    register("<localleader>s", function()
      local w = require("dap.ui.widgets")
      -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
      w.centered_float(w.scopes)
    end, { desc = "Dap Scopes" })
    -- scope
    register("<localleader>.", function()
      local w = require("dap.ui.widgets")
      -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
      w.centered_float(w.sessions, {})
    end, { desc = "Dap sessions" })
    register("<localleader>t", function()
      require("dap").terminate()
    end, { desc = "Toggle Breakpoint" })
    register("<localleader>r", function()
      require("dap").restart()
    end, { desc = "Restart" })
    register("<localleader>c", function()
      require("dap").continue()
    end, { desc = "Continue" })
    register("<localleader><localleader>", function()
      require("dap").step_over()
    end, { desc = "Step Over" })
    register("<localleader>o", function()
      require("dap").step_over()
    end, { desc = "Step Over" })
    register("<localleader>e", function()
      require("dap.ui.widgets").hover(nil, { border = "single" })
    end, { desc = "Evaluate" })
    -- register("<C-q>", nil, {  desc = "exit" })
  end,
})
