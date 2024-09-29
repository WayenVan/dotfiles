return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    opts = {
      menu = {
        win_configs = {
          border = "single",
        },
      },
    },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
}
