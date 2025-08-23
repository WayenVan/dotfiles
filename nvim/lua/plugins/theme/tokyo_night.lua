return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      -- on_highlights = function(highlights, _)
      --   -- NOTE: LSP diagnostics viitual line
      --   --
      --   -- highlights["DiagnosticWarn"] = { link = "DiagnosticVirtualTextWarn" }
      --   -- highlights["DiagnosticError"] = { link = "DiagnosticVirtualTextError" }
      --   -- highlights["DiagnosticInfo"] = { link = "DiagnosticVirtualTextInfo" }
      --   -- highlights["DiagnosticHint"] = { link = "DiagnosticVirtualTextHint" }
      --
      --   -- NOTE: DAP UI
      --   -- need to be bold
      -- end,
      plugins = {
        -- disable some plugins
        -- auto = false,
        ["neo-tree"] = false,
      },
    },
  },
}
