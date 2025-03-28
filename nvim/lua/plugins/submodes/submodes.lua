local func = require("vim.func")
return {
  {
    "pogyomo/submode.nvim",
    -- do not need to load it immediately
    lazy = true,
    init = function()
      local submode = require("submode")
      -- debug submode
      submode.create("Debug", {
        mode = "n",
        enter = "<leader>Q",
        leave = { "<C-c>", "q" },
        default = function(register)
          -- scope
          register("<localleader>s", function()
            local w = require("dap.ui.widgets")
            -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
            w.centered_float(w.scopes)
          end, { desc = "Dap Scopes" })
          -- scope
          register("<localleader>S", function()
            require("dap.ui.widgets").hover(nil, { border = "single" })
          end, { desc = "Dap Evaluate" })
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
    end,
    -- (recommended) specify version to prevent unexpected change.
    -- version = "6.0.0",
  },
}
