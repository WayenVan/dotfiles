return {
  {
    "igorlfs/nvim-dap-view",
    enabled = true,
    opts = {},
    keys = {
      { "<leader>du", "<cmd>lua require('dap-view').toggle()<CR>", desc = "Toggle dap view" },
      { "<leader>dE", "<cmd>lua require('dap-view').add_expr()<CR>", desc = "Add expression" },
    },
    config = function(_, opts)
      -- require("dap-view").setup(opts)
      local dap, dv = require("dap"), require("dap-view")
      dap.listeners.before.attach["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.before.launch["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.before.event_terminated["dap-view-config"] = function()
        dv.close()
      end
      dap.listeners.before.event_exited["dap-view-config"] = function()
        dv.close()
      end
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
        callback = function(evt)
          vim.keymap.set("n", "q", "<C-w>q", { silent = true, buffer = evt.buf })
        end,
      })
    end,
  },
}
