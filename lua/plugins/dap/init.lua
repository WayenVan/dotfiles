return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>da", "<cmd>DapNew<cr>", desc = "Create a new dap session" },
      { "<leader>dn", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over" },
    },
    config = function()
      -- setup customized adapters
      require("plugins.dap.python")

      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- Extends dap.configurations with entries read from .vscode/launch.json
      if vim.fn.filereadable(".vscode/launch.json") then
        vscode.load_launchjs()
      end

      -- setting keymaps for session selection
      vim.keymap.set("n", "<leader>ds", function()
        if #require("dap").sessions() == 0 then
          require("noice").notify("No dap session running", "info")
          return
        end
        local ui = require("dap.ui.widgets")
        local s = ui.sessions
        ui.cursor_float(s, {})
      end, { desc = "Sessions" })
    end,
  },
}
