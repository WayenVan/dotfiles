return {
  {
    "igorlfs/nvim-dap-view",
    enabled = true,
    -- branch = "feat/expand-variables",
    opts = {
      winbar = {
        sections = { "watches", "sessions", "breakpoints", "threads", "repl", "scopes", "exceptions" },
        base_sections = {
          breakpoints = {
            keymap = ",3",
            label = "Breakpoints [,3]",
            short_label = " [3]",
            action = function()
              require("dap-view.views").switch_to_view("breakpoints")
            end,
          },
          scopes = {
            keymap = ",6",
            label = "Scopes [,6]",
            short_label = "󰂥 [6]",
            action = function()
              require("dap-view.views").switch_to_view("scopes")
            end,
          },
          exceptions = {
            keymap = ",7",
            label = "Exceptions [,7]",
            short_label = "󰢃 [,7]",
            action = function()
              require("dap-view.views").switch_to_view("exceptions")
            end,
          },
          watches = {
            keymap = ",1",
            label = "Watches [,1]",
            short_label = "󰛐 [1]",
            action = function()
              require("dap-view.views").switch_to_view("watches")
            end,
          },
          threads = {
            keymap = ",4",
            label = "Threads [,4]",
            short_label = "󱉯 [,4]",
            action = function()
              require("dap-view.views").switch_to_view("threads")
            end,
          },
          repl = {
            keymap = ",5",
            label = "REPL [,5]",
            short_label = "󰯃 [,5]",
            action = function()
              require("dap-view.repl").show()
            end,
          },
          sessions = {
            keymap = ",2", -- I ran out of mnemonics
            label = "Sessions [,2]",
            short_label = " [,2]",
            action = function()
              require("dap-view.views").switch_to_view("sessions")
            end,
          },
        },
      },
      windows = {
        height = 16,
        terminal = {
          position = "right",
        },
      },
    },
    keys = {
      { "<leader>du", "<cmd>lua require('dap-view').toggle()<CR>", desc = "Toggle dap view" },
      { "<leader>de", "<cmd>lua require('dap-view').add_expr()<CR>", desc = "Add expression" },
    },
    config = function(_, opts)
      require("dap-view").setup(opts)
      local dap, dv = require("dap"), require("dap-view")
      dap.listeners.before.attach["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.before.launch["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.after.event_terminated["dap-view-config"] = function()
        if require("dap").session() == nil then
          dv.close()
        end
      end
      dap.listeners.after.event_exited["dap-view-config"] = function()
        if require("dap").session() == nil then
          dv.close()
        end
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
