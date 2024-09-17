return {
  "folke/neoconf.nvim",
  keys = {
    { "<leader>N", "", desc = "+neoconfig" },
    { "<leader>Nc", "<cmd>Neoconf show<cr>", desc = "Show neoconf merge config" },
    { "<leader>Nl", "<cmd>Neoconf lsp<cr>", desc = "Show neoconf merge Lsp config" },
    { "<leader>Ns", "<cmd>Neoconf<cr>", desc = "Select local/global config" },
  },
}
