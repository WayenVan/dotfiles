return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {--[[ things you want to change go here]]
      direction = "horizontal",
    },
    keys = {
      { "<c-/>", "<cmd>exe v:count1 . 'ToggleTerm'<cr>", noremap = true, silent = true, mode = "n" },
      { "<c-/>", "<Esc><cmd>exe v:count1 . 'ToggleTerm'<cr>", noremap = true, silent = true, mode = "i" },
    },
  },
}
