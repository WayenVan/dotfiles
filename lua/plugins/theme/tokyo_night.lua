return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      on_highlights = function(highlights, colors)
        -- need to be bold
        -- bold cyan
        highlights["DapUIWinSelect"] = { link = "@markup.heading.1.markdown" }

        -- bold gree
        highlights["DapUIModifiedValue"] = { link = "@markup.heading.4.markdown" }
        highlights["DapUIBreakpointsCurrentLine"] = { link = "@markup.heading.4.markdown" }
        highlights["DapUICurrentFrameName"] = { link = "@markup.heading.4.markdown" }

        --cyan
        highlights["DapUIScope"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepOver"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepOverNC"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepInto"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepIntoNC"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepOut"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepOutNC"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepBack"] = { link = "@lsp.type.variable" }
        highlights["DapUIStepBackNC"] = { link = "@lsp.type.variable" }
        highlights["DapUILineNumber"] = { link = "@lsp.type.variable" }
        highlights["DapUIDecoration"] = { link = "@lsp.type.variable" }
        highlights["DapUIBreakpointsPath"] = { link = "@lsp.type.variable" }
        highlights["DapUIBreakpointsLine"] = { link = "@lsp.type.variable" }
        highlights["DapUIStoppedThread"] = { link = "@lsp.type.variable" }

        -- green
        highlights["DapUIRestart"] = { link = "@attribute" }
        highlights["DapUIRestartNC"] = { link = "@attribute" }
        highlights["DapUIPlayPause"] = { link = "@attribute" }
        highlights["DapUIPlayPauseNC"] = { link = "@attribute" }
        highlights["DapUIThread"] = { link = "@attribute" }
        highlights["DapUIBreakpointsInfo"] = { link = "@attribute" }
        highlights["DapUIWatchesValue"] = { link = "@attribute" }
      end,
    },
  },
}
