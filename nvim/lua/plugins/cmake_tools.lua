return {
  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_regenerate_on_save = false,
    },
    config = function(_, opts)
      require("cmake-tools").setup(opts)
      local set = vim.keymap.set

      set("n", "<localleader>cc", "<cmd>CMakeGenerate<CR>", { noremap = true })
      set("n", "<localleader>cb", "<cmd>CMakeBuild<CR>", { noremap = true })
    end,
  },
}
