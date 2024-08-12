return {
  {
    "folke/which-key.nvim",
    ---@param opts table
    opts = function(_, opts)
      table.insert(opts.spec, { "<leader>o", group = "C(o)nfigs", icon = "🤓" })
      return opts
    end,
  },
}
