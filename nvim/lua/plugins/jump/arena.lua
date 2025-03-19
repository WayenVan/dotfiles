return {
  {
    "dzfrias/arena.nvim",
    event = "BufWinEnter",
    -- Calls `.setup()` automatically
    keys = {
      {
        "<leader>.",
        function()
          require("arena").toggle()
        end,
        desc = "arena",
      },
    },
    config = true,
  },
}
