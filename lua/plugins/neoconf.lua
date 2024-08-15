return {
  "folke/neoconf.nvim",
  keys = {
    { "<leader>nf", "", desc = "+neoconfig" },
    { "<leader>nfs", "<cmd>Neoconf show<cr>", desc = "Show neoconf merge config" },
    { "<leader>nfl", "<cmd>Neoconf lsp<cr>", desc = "Show neoconf merge Lsp config" },
    { "<leader>nfS", "<cmd>Neoconf<cr>", desc = "Select local/global config" },
  },
}
