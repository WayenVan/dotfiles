return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      -- disable the c-p
      opts.defaults.mappings.i["<C-p>"] = false
      opts.defaults.mappings.i["<C-n>"] = false

      -- change selection to j and k
      opts.defaults.mappings.i["<C-j>"] = actions.move_selection_next

      opts.defaults.mappings.i["<C-k>"] = actions.move_selection_previous

      return opts
    end,
  },
}
