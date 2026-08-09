return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      on_highlights = function(highlights, colors)
        -- NOTE: LSP diagnostics viitual line
        --
        -- highlights["DiagnosticWarn"] = { link = "DiagnosticVirtualTextWarn" }
        -- highlights["DiagnosticError"] = { link = "DiagnosticVirtualTextError" }
        -- highlights["DiagnosticInfo"] = { link = "DiagnosticVirtualTextInfo" }
        -- highlights["DiagnosticHint"] = { link = "DiagnosticVirtualTextHint" }
        highlights["MsgSeparator"] = { link = "PmenuSel" }
        highlights["TinyCmdlineBorder"] = { link = "Type" }
        highlights["InclineNormal"] = { link = "CursorLine" }
        -- highlights["InclineNormalNC"] = { link = "PmenuThumb" }

        -- NOTE: DAP UI
        -- need to be bold
      end,
      plugins = {
        -- disable some plugins
        -- auto = false,
        ["neo-tree"] = false,
      },
    },
  },
}
