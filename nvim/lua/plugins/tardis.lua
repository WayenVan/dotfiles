return {
  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>gT",
        function()
          vim.cmd("vsplit")
          vim.cmd("Tardis")
        end,
        desc = "Git Tardis",
      },
    },
    config = true,
  },
}
