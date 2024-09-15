return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "LazyFile",
    keys = {
      { "gs", "", desc = "+go surround" },
    },
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          -- insert = "<C-g>s",
          -- insert_line = "<C-g>S",
          insert = false,
          insert_line = false,
          normal = "gsa",
          normal_cur = "gsA",
          normal_line = "gsl",
          normal_cur_line = "gsL",
          visual = "gsa",
          visual_line = "gsA",
          delete = "gsd",
          change = "gsc",
          change_line = "gsC",
        },
      })
    end,
  },
}
