return {
  {
    "neanias/everforest-nvim",
    version = false,
    -- lazy = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    opts = {
      background = "hard",
      diagnostic_text_highlight = false,
      on_highlights = function(hl, palette) end,
    },
    config = function(_, opts)
      require("everforest").setup(opts)
    end,
  },
}
