-- repalced by snacks.nvim
return {
  {
    "pteroctopus/faster.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      behaviours = {
        bigfile = {
          filesize = 0.5,
        },
      },
    },
  },
}
