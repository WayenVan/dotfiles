return {
  {
    "cxwx/specs.nvim",
    -- lazy = false,

    keys = {
      { "<leader>;", "<cmd>lua require('specs').show_specs()<CR>", desc = "Show jump specs" },
    },
    config = function(_, opts)
      require("specs").setup({
        show_jumps = false,
        min_jump = 30,
        popup = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 8, -- time increments used for fade/resize effects
          blend = 0, -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 30,
          winhl = "IncSearch",
          fader = require("specs").linear_fader,
          resizer = require("specs").shrink_resizer,
        },
        ignore_filetypes = {},
        ignore_buftypes = {
          nofile = true,
        },
      })
    end,
  },
}
