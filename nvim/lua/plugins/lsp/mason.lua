return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = vim.list_extend(opts.ensure_installed, { "tex-fmt", "ty", "pyrefly" })
    opts.registries = { "lua:my-mason-registry", "github:mason-org/mason-registry" }
  end,
}
