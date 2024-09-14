return {
  {
    "nvimdev/lspsaga.nvim",
    event = "VeryLazy",
    enabled = false,
    opts = {
      symbol_in_winbar = {
        enable = false,
        show_file = false,
      },
      lightbulb = {
        enable = false,
      },
      outline = {
        enable = false,
        win_width = 40,
        keys = {
          toggle_or_jump = "<cr>",
          jump = "o",
        },
      },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
    keys = {
      -- { "<leader>cs", "<cmd>Lspsaga outline<cr>", desc = "Show symbole (Lspsaga)" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
    },
  },
}
