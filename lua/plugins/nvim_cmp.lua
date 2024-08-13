return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-emoji" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping["<C-N>"] = cmp.config.disable
      opts.mapping["<C-P>"] = cmp.mapping.complete()
      opts.mapping["<C-j>"] = cmp.mapping.select_next_item()
      opts.mapping["<C-k>"] = cmp.mapping.select_prev_item()
      return opts
    end,
  },
}
