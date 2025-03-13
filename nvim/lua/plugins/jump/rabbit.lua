return {
  {
    "voxelprismatic/rabbit.nvim",
    event = "BufRead",
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
