return {
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "<leader>.",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      ui = {
        position = "center",
      },
      navigate = {
        cancel_snipe = "q",
      },
      sort = "last",
    },
  },
}
