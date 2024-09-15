return {
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.consumers.overseer = nil
      -- opts.adapters["neotest-python"] = {
      --   runner = "pysd",
      -- }
    end,
  },
}
