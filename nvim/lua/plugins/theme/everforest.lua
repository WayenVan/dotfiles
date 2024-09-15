return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    opts = {
      on_highlights = function(hl, palette)
        local log = require("plenary.log"):new()
        if LazyVim.has("avante.nvim") then
          require("utils.ui").setup_hl_vante(hl)
          log.info("avante is loaded")
        end
      end,
    },
    config = function(_, opts)
      require("everforest").setup(opts)
    end,
  },
}
