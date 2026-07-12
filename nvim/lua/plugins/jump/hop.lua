return {
  {
    "smoka7/hop.nvim",
    version = "*",
    event = "VeryLazy",
    vscode = true,
    keys = {
      -- { "<leader>j", "<cmd>HopLineStartAC<cr>", desc = "Hop line", mode = { "n", "v" } },
      -- { "<leader>k", "<cmd>HopLineStartBC<cr>", desc = "Hop line", mode = { "n", "v" } },
      { "<leader>j", "<cmd>HopVerticalAC<cr>", desc = "Hop line", mode = { "n", "v" } },
      { "<leader>k", "<cmd>HopVerticalBC<cr>", desc = "Hop line", mode = { "n", "v" } },
      { "f", "<cmd>HopCamelCaseAC<cr>", desc = "Hop line", mode = { "n", "v" } },
      { "F", "<cmd>HopCamelCaseBC<cr>", desc = "Hop line", mode = { "n", "v" } },
    },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },
}
