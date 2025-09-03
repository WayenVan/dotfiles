return {
  {
    "stevearc/conform.nvim",
    enabled = true,
    opts = {
      formatters_by_ft = {
        tex = { "tex-fmt" },
        python = { "ruff" },
      },
    },
  },
}
