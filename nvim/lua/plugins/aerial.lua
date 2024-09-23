return {
  "stevearc/aerial.nvim", --
  opts = function(_, opts)
    opts.layout.max_width = { 0.4 }
    opts.layout.min_width = 0.25
    opts.default_direction = "right"
  end,
}
