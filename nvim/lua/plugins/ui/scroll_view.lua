-- being replaced by mini_map
return {
  "dstein64/nvim-scrollview",
  -- event = "BufEnter",
  lazy = false,
  enabled = true,
  opts = {
    excluded_filetypes = {
      "neo-tree",
      "dashboard",
      "snacks_dashboard",
      "alpha",
      "ministarter",
      "TelescopePrompt",
      "snacks_picker_input",
    },
    current_only = true,
    base = "right",
    column = 1,
    signs_on_startup = { "all" },
    -- diagnostics_severities = { vim.diagnostic.severity.ERROR },
  },
}
