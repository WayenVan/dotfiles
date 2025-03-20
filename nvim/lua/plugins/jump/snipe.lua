return {
  {
    "leath-dub/snipe.nvim",
    event = "BufRead",
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
  {
    "kungfusheep/snipe-spell.nvim",
    dependencies = "leath-dub/snipe.nvim",
    enabled = false,
    event = "BufEnter",
    config = true,
    keys = {
      { "z=", "<cmd>SnipeSpell <cr>", desc = "Snipe Spellchecker" },
    },
  },
}
