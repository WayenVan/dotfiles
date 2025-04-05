return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = false,
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts = {
      options = {
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    },
    config = function(_, opts)
      require("tiny-inline-diagnostic").setup(opts)
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
