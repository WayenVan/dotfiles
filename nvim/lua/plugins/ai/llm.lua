return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    keys = {
      { "<leader>A", mode = "n", "<cmd>LLMSessionToggle<cr>" },
    },
  },
}
