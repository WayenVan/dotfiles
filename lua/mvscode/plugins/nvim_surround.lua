return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    keys = {
      { "gs", "", desc = "go surround" },
    },
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          -- insert = "<C-g>s",
          -- insert_line = "<C-g>S",
          insert = nil,
          insert_line = nil,
          normal = "gsa",
          normal_cur = "gsa",
          normal_line = "gsa",
          normal_cur_line = "gsa",
          visual = "gsa",
          visual_line = "gsa",
          delete = "gsd",
          change = "gsc",
          change_line = "gsc",
        },
      })
    end,
  },
}
