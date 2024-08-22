return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          -- You can change the order of elements in the sidebar
          elements = {
            -- Provide IDs as strings or tables with "id" and "size" keys
            {
              id = "scopes",
              size = 0.25, -- Can be float or integer > 1
            },
            { id = "watches", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
          },
          size = 40,
          position = "left", -- Can be "left" or "right"
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      local tree = require("neo-tree.command")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        tree.execute({
          action = "close",
        })
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
