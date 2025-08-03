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
      -- 模拟“按住显示 200 ms 后自动隐藏”的脚本 hack
      keys[#keys + 1] = {
        "<M-h>",
        function()
          print("Momentarily show inlay hints via Alt‑h")
          local bufnr = vim.api.nvim_get_current_buf()
          local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
          if not enabled then
            vim.lsp.inlay_hint.enable(true, {
              bufnr = bufnr,
            })
          else
            vim.lsp.inlay_hint.enable(false, {
              bufnr = bufnr,
            })
          end
        end,
        desc = "Momentarily show inlay hints via Alt‑h",
        mode = "n",
      }

      -- disable diagnostic virtual text configured by lspconfig, using the tiny one
      opts.diagnostics.virtual_text = false
      opts.inlay_hints = {
        enabled = false,
      }

      -- vim.diagnostic.config({ virtual_lines = true })
      -- disalbe vim log
      -- vim.lsp.set_log_level("off")

      -- toggle diagnostic virtual text
      -- vim.keymap.set("", "<leader>k", function()
      --   vim.diagnostic.config({
      --     virtual_lines = not vim.diagnostic.config().virtual_lines,
      --     virtual_text = not vim.diagnostic.config().virtual_text,
      --   })
      -- end, { desc = "Toggle diagnostic [l]ines" })
      vim.diagnostic.config({ float = { source = true } })
    end,
  },
}
