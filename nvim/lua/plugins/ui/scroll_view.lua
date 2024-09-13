return {
  "dstein64/nvim-scrollview",
  event = "BufEnter",
  opts = {
    excluded_filetypes = { "neo-tree" },
    current_only = true,
    base = "buffer",
    column = 1,
    signs_on_startup = { "all" },
    diagnostics_severities = { vim.diagnostic.severity.ERROR },
  },
}
