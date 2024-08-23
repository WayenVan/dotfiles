return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      on_highlights = function(highlights, colors)
        -- need to be bold
        highlights["DapUIWinSelect"] = { link = "@markup.heading.1.markdown" }
        -- bold
        highlights["DapUIModifiedValue"] = { link = "@markup.list.markdown" }
        -- bold
        highlights["DapUIBreakpointsCurrentLine"] = { link = "@markup.list.markdown" }

        --cyan
        highlights["DapUIScope"] = { link = "@lsp.type.variable" }
        highlights["DapUILineNumber"] = { link = "Normal" }
        highlights["DapUIDecoration"] = { link = "@lsp.type.variable" }

        -- breakpoint
        highlights["DapUIBreakpointsPath"] = { link = "Directory" }
        highlights["DapUIBreakpointsLine"] = { link = "Normal" }

        -- thread
        highlights["DapUICurrentFrameName"] = { link = "CursorLineNr" }
        highlights["DapUIStoppedThread"] = { link = "Title" }
        highlights["DapUIThread"] = { link = "@attribute" }

        --button
        highlights["DapUIStepOverNC"] = { link = "@attribute" }
        highlights["DapUIStepIntoNC"] = { link = "@attribute" }
        highlights["DapUIStepOutNC"] = { link = "@attribute" }
        highlights["DapUIStepBackNC"] = { link = "@attribute" }

        -- button
        highlights["DapUIStepOver"] = { link = "@attribute" }
        highlights["DapUIStepInto"] = { link = "@attribute" }
        highlights["DapUIStepOut"] = { link = "@attribute" }
        highlights["DapUIStepBack"] = { link = "@attribute" }

        highlights["DapUIRestart"] = { link = "@attribute" }
        highlights["DapUIPlayPause"] = { link = "@attribute" }
        highlights["DapUIRestartNC"] = { link = "@attribute" }
        highlights["DapUIPlayPauseNC"] = { link = "@attribute" }

        highlights["DapUIBreakpointsInfo"] = { link = "@attribute" }
        highlights["DapUIWatchesValue"] = { link = "@attribute" }

        -- not avialiable
        highlights["DapUIUnavailable"] = { link = "NonText" }
        highlights["DapUIUnavailableNC"] = { link = "NonText" }

        -- type and source
        highlights["DapUIType"] = { link = "Type" }
        highlights["DapUISource"] = { link = "Directory" }
      end,
    },
  },
}

---@class OK
