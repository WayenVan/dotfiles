return {
  {
    "A7Lavinraj/fyler.nvim",
    -- dependencies = { "echasnovski/mini.icons" },
    enabled = false,
    dependencies = { "DaikyXendo/nvim-material-icon" },
    -- branch = "stable",
    keys = {
      {
        "<leader>r",
        function()
          require("fyler").open({ enter = false })
        end,
        desc = "Open Fyler Explorer",
      },
    },
    opts = {
      icon_provider = "nvim-web-devicons",
      views = {
        explorer = {
          win = {
            kind = "split_left_most",
            kind_presets = {
              split_left_most = {
                width = "0.2rel",
              },
            },
          },
        },
      },
    },
  },
}
