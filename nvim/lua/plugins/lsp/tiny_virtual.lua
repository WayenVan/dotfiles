return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = true,
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts = {
      options = {
        show_source = {
          enabled = true,
          if_many = true,
        },
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    },
    config = function(_, opts)
      require("tiny-inline-diagnostic").setup(opts)
      -- vim.diagnostic.config({ virtual_text = false })
      -- Only if needed in your configuration, if you already have native LSP diagnostics
      vim.keymap.set("", "<leader>k", function()
        require("tiny-inline-diagnostic").toggle()
        vim.diagnostic.config({
          virtual_lines = not vim.diagnostic.config().virtual_lines,
        })
      end, { desc = "Toggle diagnostic [l]ines" })
    end,
  },
}
