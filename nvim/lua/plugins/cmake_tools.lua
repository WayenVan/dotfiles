return {
  {
    "Civitasv/cmake-tools.nvim",
    config = function(_, opts)
      require("cmake-tools").setup(opts)
      local set = vim.keymap.set

      set("n", "<localleader>cc", "<cmd>CMakeGenerate<CR>", { noremap = true })
      set("n", "<localleader>cb", "<cmd>CMakeBuild<CR>", { noremap = true })
    end,
  },
}
