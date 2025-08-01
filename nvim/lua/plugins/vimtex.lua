return {
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    -- enabled = false,
    keys = function(_, keys)
      return {}
    end,
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_mappings_enabled = false
      vim.g.vimtex_syntax_conceal_disable = true
      vim.g.vimtex_format_enabled = true
    end,
  },
}
