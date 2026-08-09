return {
  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_regenerate_on_save = false,
    },
    config = function(_, opts)
      require("cmake-tools").setup(opts)
      local set = vim.keymap.set

      local wk = require("which-key")
      wk.add({
        { "<localleader>c", icon = "", desc = "+cmake" },
      }, {
        created = true,
      })
      set("n", "<localleader>cc", "<cmd>CMakeGenerate<CR>", { noremap = true })
      set("n", "<localleader>cb", "<cmd>CMakeBuild<CR>", { noremap = true })
    end,
  },
}
