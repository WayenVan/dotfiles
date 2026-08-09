return {
  {
    {
      "nvim-mini/mini-git",
      version = false,
      cmd = { "Git" },
      main = "mini.git",
      config = function(_, opts)
        require("mini.git").setup(opts)
      end,
    },
  },
}
