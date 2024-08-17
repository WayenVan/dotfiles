return {
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmds = {
      "DiffviewOpen",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
    },
  },
}
