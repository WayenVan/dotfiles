return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-emoji" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      -- opts.mapping["<C-N>"] = cmp.config.disable
      -- opts.mapping["<C-P>"] = cmp.mapping.complete()
      -- opts.mapping["<C-P>"] = cmp.config.disable
      -- opts.mapping["<C-J>"] = cmp.mapping.select_next_item()
      -- opts.mapping["<C-K>"] = cmp.mapping.select_prev_item()
      opts.mapping["<CR>"] = cmp.config.disable
    end,
  },
}
