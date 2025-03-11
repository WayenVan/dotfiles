-- being replaced by mini_map
return {
  "dstein64/nvim-scrollview",
  event = "BufEnter",
  enabled = false,
  opts = {
    excluded_filetypes = { "neo-tree", "dashboard" },
    current_only = true,
    base = "right",
    column = 1,
    signs_on_startup = { "all" },
    -- diagnostics_severities = { vim.diagnostic.severity.ERROR },
  },
}
