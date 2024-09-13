return {
  {
    "utilyre/sentiment.nvim",
    event = "BufEnter",
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
