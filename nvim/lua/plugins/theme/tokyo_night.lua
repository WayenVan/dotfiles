return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      on_highlights = function(highlights, colors)
        require("utils.ui").setup_hl_dapui(highlights)
      end,
    },
  },
}
