return {
  -- change lsp keymaps
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
      keys[#keys + 1] = {
        "<C-k>",
        false,
        mode = "i",
      }
      keys[#keys + 1] = {
        "<C-g>",
        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        desc = "open lsp signature help",
        mode = "i",
      }
      -- disable a keymap
      -- keys[#keys + 1] = { "<leader>ca", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },
}
