return {
  {
    -- conflict with auto_session.nvim in storing sessions
    enabled = false,
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
