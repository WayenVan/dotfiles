return {
  {
    {
      "echasnovski/mini-git",
      version = false,
      main = "mini.git",
      config = function(_, opts)
        require("mini.git").setup(opts)
      end,
    },
  },
}
