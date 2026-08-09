return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    init = function()
      vim.g.nvim_surround_no_visual_mappings = 1
    end,
    keys = {
      {
        "gS",
        mode = { "x" },
        "<Plug>(nvim-surround-visual-line)",
        desc = "Surround visual line",
      },
      {
        "gs",
        mode = { "x" },
        "<Plug>(nvim-surround-visual)",
        desc = "Surround visual",
      },
    },
  },
}
