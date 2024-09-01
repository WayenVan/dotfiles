local M = {}

function M.setup_hl_dapui(highlights)
  -- need to be bold
  highlights["DapUIWinSelect"] = { link = "@markup.heading.1.markdown" }
  highlights["DapUIModifiedValue"] = { link = "@markup.list.markdown" }
  highlights["DapUIValue"] = { link = "LspKindValue" }

  --cyan
  highlights["DapUIScope"] = { link = "LspKindNamespace" }
  highlights["DapUILineNumber"] = { link = "LspKindNumber" }
  highlights["DapUIDecoration"] = { link = "@lsp.type.variable" }

  -- breakpoint
  highlights["DapUIBreakpointsCurrentLine"] = { link = "@markup.list.markdown" }
  highlights["DapUIBreakpointsInfo"] = { link = "@attribute" }
  highlights["DapUIBreakpointsPath"] = { link = "Directory" }
  highlights["DapUIBreakpointsLine"] = { link = "LspKindNumber" }

  -- thread
  highlights["DapUICurrentFrameName"] = { link = "LspKindNamespace" }
  highlights["DapUIStoppedThread"] = { link = "Title" }
  highlights["DapUIThread"] = { link = "@attribute" }

  --button
  highlights["DapUIStepOver"] = { link = "@attribute" }
  highlights["DapUIStepInto"] = { link = "@attribute" }
  highlights["DapUIStepOut"] = { link = "@attribute" }
  highlights["DapUIStepBack"] = { link = "@attribute" }
  highlights["DapUIStepOverNC"] = { link = "@attribute" }
  highlights["DapUIStepIntoNC"] = { link = "@attribute" }
  highlights["DapUIStepOutNC"] = { link = "@attribute" }
  highlights["DapUIStepBackNC"] = { link = "@attribute" }

  -- button2
  highlights["DapUIRestart"] = { link = "@attribute" }
  highlights["DapUIPlayPause"] = { link = "@attribute" }
  highlights["DapUIRestartNC"] = { link = "@attribute" }
  highlights["DapUIPlayPauseNC"] = { link = "@attribute" }

  -- button3
  highlights["DapUIStop"] = { link = "Error" }
  highlights["DapUIStopNC"] = { link = "Error" }

  highlights["DapUIWatchesValue"] = { link = "LspKindValue" }
  highlights["DapUIWatchesError"] = { link = "Error" }
  highlights["DapUIWatchesEmpty"] = { link = "Error" }

  -- not avialiable
  highlights["DapUIUnavailable"] = { link = "NonText" }
  highlights["DapUIUnavailableNC"] = { link = "NonText" }

  -- type and source
  highlights["DapUIType"] = { link = "LspKindClass" }
  highlights["DapUISource"] = { link = "Directory" }

  highlights["DapUIVariable"] = { link = "Directory" }
end
return M
