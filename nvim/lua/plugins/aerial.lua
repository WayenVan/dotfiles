return {
  "stevearc/aerial.nvim", --
  opts = function(_, opts)
    opts.layout.max_width = 0.2
    opts.layout.min_width = 0.15
    opts.default_direction = "right"
    opts.layout.placement = "edge"
  end,
}
