return {
  {
    "voxelprismatic/rabbit.nvim",
    lazy = false,
    enabled = false,
    branch = "rewrite",
    config = function()
      require("rabbit").setup({
        keys = {
          switch = "<leader>,",
        },
        window = {
          spawn = {
            side = "c",
          },
        },
      }) -- Detailed below
    end,
  },
}
