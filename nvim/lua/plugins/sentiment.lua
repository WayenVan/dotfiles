return {
  {
    "utilyre/sentiment.nvim",
    lazy = false,
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
      vim.opt.showmatch = true
    end,
    config = function()
      require("sentiment").setup({})
    end,
  },
}
