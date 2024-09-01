return {
  "folke/neoconf.nvim",
  keys = {
    { "<leader>nc", "", desc = "+neoconfig" },
    { "<leader>ncc", "<cmd>Neoconf show<cr>", desc = "Show neoconf merge config" },
    { "<leader>ncl", "<cmd>Neoconf lsp<cr>", desc = "Show neoconf merge Lsp config" },
    { "<leader>ncs", "<cmd>Neoconf<cr>", desc = "Select local/global config" },
  },
}
