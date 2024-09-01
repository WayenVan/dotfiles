return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        -- don't need to load for dapui
        on_highlights = function(hl, palette)
          hl["WinBar"] = { link = "Normal" }
          hl["WinBarNC"] = { link = "Normal" }
        end,
      })
    end,
  },
}
