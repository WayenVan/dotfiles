return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      -- { "igorlfs/nvim-dap-view" },
    },
    keys = {
      { "<leader>dR", "<cmd>lua require('dap').restart()<cr>", desc = "Restart" },
      { "<leader>da", "<cmd>DapNew<cr>", desc = "Create a new dap session" },
      { "<leader>dn", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over" },
      {
        "<leader>dS",
        function()
          local w = require("dap.ui.widgets")
          -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
          w.centered_float(w.sessions)
        end,
        desc = "Dap Sessions",
      },
      {
        "<leader>ds",
        function()
          local w = require("dap.ui.widgets")
          -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
          w.centered_float(w.scopes)
        end,
        desc = "Dap Scopes",
      },
      {
        "<leader>de",
        function()
          require("dap.ui.widgets").hover(nil, { border = "single" })
        end,
        desc = "Dap Scopes",
      },
    },

    opts = function()
      -- require custom configuration
      local customized_configuration = {
        python = "plugins.dap.configs.python",
      }
      for name, module in pairs(customized_configuration) do
        require(module)
      end

      -- auto command for filetype dap-float
      vim.api.nvim_create_augroup("Dap_", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = "Dap_",
        pattern = { "dap-float" },
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.api.nvim_buf_set_keymap(buf, "n", "q", "<CMD>q<CR>", { noremap = true, silent = true })
        end,
      })
    end,
    --   config = function()
    --     -- load mason-nvim-dap here, after all adapters have been setup
    --     if LazyVim.has("mason-nvim-dap.nvim") then
    --       require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    --     end
    --
    --     vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    --     for name, sign in pairs(LazyVim.config.icons.dap) do
    --       sign = type(sign) == "table" and sign or { sign }
    --       vim.fn.sign_define(
    --         "Dap" .. name,
    --         { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --       )
    --     end
    --
    --     -- setup dap config by VsCode launch.json file
    --     local vscode = require("dap.ext.vscode")
    --     local json = require("plenary.json")
    --     vscode.json_decode = function(str)
    --       return vim.json.decode(json.json_strip_comments(str))
    --     end
    --
    --     -- Extends dap.configurations with entries read from .vscode/launch.json
    --     if vim.fn.filereadable(".vscode/launch.json") then
    --       vscode.load_launchjs()
    --     end
    --
    --     -- setting keymaps for session selection
    --     vim.keymap.set("n", "<leader>ds", function()
    --       if #require("dap").sessions() == 0 then
    --         require("noice").notify("No dap session running", "info")
    --         return
    --       end
    --       local ui = require("dap.ui.widgets")
    --       local s = ui.sessions
    --       ui.cursor_float(s, {})
    --     end, { desc = "Sessions" })
    --     -- set auto command for session window
    --     vim.api.nvim_create_augroup("Dap_", { clear = true })
    --     vim.api.nvim_create_autocmd({ "FileType" }, {
    --       group = "Dap_",
    --       pattern = { "dap-float" },
    --       callback = function()
    --         local buf = vim.api.nvim_get_current_buf()
    --         vim.api.nvim_buf_set_keymap(buf, "n", "q", "<CMD>q<CR>", { noremap = true, silent = true })
    --       end,
    --     })
    --
    --     -- add custom dap configuration, should run
    --     local customized_configuration = {
    --       python = "plugins.dap.configs.python",
    --     }
    --     for name, module in pairs(customized_configuration) do
    --       require(module)
    --     end
    --   end,
  },
}
