local leet_arg = "leetcode.nvim"
return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = { arg = leet_arg },
    cmd = "Leet",
    build = ":TSUpdate html",
    dependencies = {
      -- "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",
      -- "ibhagwan/fzf-lua",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      -- "nvim-tree/nvim-web-devicons",
    },
  },
}
