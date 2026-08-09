return {
  {

    "SmiteshP/nvim-navic",
    opts = {
      highlight = true,
    },
    config = function(opts)
      require("nvim-navic").setup(opts)
    end,
  },
}
