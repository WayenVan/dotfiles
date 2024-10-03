return {
  {
    "sindrets/diffview.nvim", -- optional - Diff integration
    cmd = {
      "DiffviewFileHistory",
    },
    opts = {
      keymaps = {
        file_history_panel = {
          { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Quit" } },
        },
        file_panel = {
          { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Quit" } },
        },
        view = {
          { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Quit" } },
        },
      },
    },
    keys = {
      { "<leader>gdf", "<CMD>DiffviewFileHistory<CR>", desc = "file history" },
      { "<leader>gdF", "<CMD>DiffviewFileHistory %<CR>", desc = "Current file history" },
      { "<leader>gdd", "<CMD>DiffviewOpen<CR>", desc = "open" },
      { "<leader>gd", "", desc = "+diffview" },
    },
  },
}
