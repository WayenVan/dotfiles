return {
  {
    "r0nsha/multinput.nvim",
    -- opts = {
    --   -- Your custom configuration goes here
    -- },
    config = function(_, opts)
      require("multinput").setup(opts)
    end,
  },
}
