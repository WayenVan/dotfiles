return {
  {
    "voxelprismatic/rabbit.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>`", "<cmd>Rabbit<cr>", desc = "Jump to definition" },
    },
    config = function()
      require("rabbit").setup({
        window = {
          -- float = { "top", "left" },
          float = "center",
        },
        default_keys = {
          open = { "<leader>`" },
        },
      }) -- Detailed below
    end,
  },
}
