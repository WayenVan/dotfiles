return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual", -- or 'background'
        exclude_filetypes = { "bigfile", "alpha", "NvimTree", "TelescopePrompt", "Trouble", "lazy", "mason", "notify" },
      })
    end,
  },
}
