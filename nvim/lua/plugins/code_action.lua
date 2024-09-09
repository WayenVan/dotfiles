return {
  {
    "aznhe21/actions-preview.nvim",
    lazy = true,
  },
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
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
      -- disable a keymap
      -- keys[#keys + 1] = { "<leader>ca", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },
}
