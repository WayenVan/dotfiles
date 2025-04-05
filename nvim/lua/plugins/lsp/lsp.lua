return {
  -- change lsp keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      --
      keys[#keys + 1] = {
        "<leader>ca",
        function()
          require("actions-preview").code_actions()
        end,
        desc = "Code action preview",
      }
      keys[#keys + 1] = {
        "<C-k>",
        false,
        mode = "i",
      }
      keys[#keys + 1] = {
        "<M-s>",
        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        desc = "open lsp signature help",
        mode = "i",
      }

      -- disable diagnostic virtual text configured by lspconfig, using the tiny one
      opts.diagnostics.virtual_text = false
      vim.diagnostic.config({ virtual_lines = true })
    end,
  },
}
