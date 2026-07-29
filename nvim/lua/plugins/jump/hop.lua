return {
  {
    "smoka7/hop.nvim",
    version = "*",
    event = "VeryLazy",
    vscode = true,
    keys = {
      -- { "<leader>j", "<cmd>HopLineStartAC<cr>", desc = "Hop line", mode = { "n", "v" } },
      -- { "<leader>k", "<cmd>HopLineStartBC<cr>", desc = "Hop line", mode = { "n", "v" } },
      { "<leader>j", "<cmd>HopCamelCaseAC<cr>", desc = "Hop line", mode = { "n", "v" } },
      { "<leader>k", "<cmd>HopCamelCaseBC<cr>", desc = "Hop line", mode = { "n", "v" } },
    },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },
}
