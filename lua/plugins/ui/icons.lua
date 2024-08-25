return {
  {
    "kyazdani42/nvim-web-devicons",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("nvim-web-devicons").setup({})
    end,
  },
  {
    "DaikyXendo/nvim-material-icon",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      override = {
        yaml = {
          icon = "",
          color = "#ffbc03",
          cterm_color = "32",
          name = "yaml",
        },
      },
      override_by_extension = {
        ["c++"] = {
          icon = "",
          color = "#0188d1",
          cterm_color = "32",
          name = "cjj",
        },
        ["h++"] = {
          icon = "",
          color = "#0188d1",
          cterm_color = "32",
          name = "hjj",
        },
      },
    },
  },
}
