return {
  -- change lsp keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      --
      vim.list_extend(keys, {
        {
          "<leader>ca",
          function()
            require("actions-preview").code_actions()
          end,
          desc = "Code action preview",
        },
        {
          "<C-k>",
          false,
          mode = "i",
        },
        {
          "<M-s>",
          "<cmd>lua vim.lsp.buf.signature_help()<cr>",
          desc = "open lsp signature help",
          mode = "i",
        },
        {
          "<M-i>",
          function()
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
        },
        -- {
        --   "<leader>ss",
        --   function()
        --     Snacks.picker.lsp_symbols({
        --       filter = LazyVim.config.kind_filter,
        --     })
        --   end,
        --   desc = "LSP Symbols",
        --   has = "documentSymbol",
        -- },
      })

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
