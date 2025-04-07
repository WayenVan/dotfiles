return {
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gT", "<cmd>Tardis<cr>", desc = "Git Tardis" },
    },
    config = true,
  },
}
