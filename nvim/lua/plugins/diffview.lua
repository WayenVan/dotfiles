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
        view = {
          { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Quit" } },
        },
      },
    },
    keys = {
      { "<leader>gD", "<CMD>DiffviewFileHistory<CR>", desc = "Diffview file history" },
    },
  },
}
