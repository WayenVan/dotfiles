return {
  {
    "nullromo/cash.nvim",
    lazy = false,
    keys = {
      { "<leader>;", desc = "Choose Cash register" },
      { "<leader>:", "<cmd>Cash<cr>", desc = "Open Cash drawer" },
    },
    opts = {},
    config = function(_, opts)
      local cash = require("cash")
      cash.setup(opts)

      local chooser = vim.fn.maparg("?", "n", false, true)
      vim.keymap.del("n", "?")
      vim.keymap.set("n", "<leader>;", chooser.callback, { desc = "Choose Cash register" })
    end,
  },
}
