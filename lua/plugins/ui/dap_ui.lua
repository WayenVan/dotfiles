return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      layouts = {
        {
          -- You can change the order of elements in the sidebar
          elements = {
            -- Provide IDs as strings or tables with "id" and "size" keys
            {
              id = "scopes",
              size = 0.25, -- Can be float or integer > 1
            },
            { id = "watches", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
          },
          size = 50,
          position = "left", -- Can be "left" or "right"
        },
        {
          elements = {
            { id = "repl", size = 0.4 },
            { id = "console", size = 0.6 },
            -- "repl",
            -- "console",
          },
          size = 10,
          position = "bottom", -- Can be "bottom" or "top"
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      local tree = require("neo-tree.command")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        tree.execute({
          action = "close",
        })
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end

      -- set hgith light group
      --
    end,
  },
}
-- hi default link DapUINormal Normal
-- hi default link DapUIVariable Normal
-- hi default link DapUIFrameName Normal
-- hi default link DapUIFloatNormal NormalFloat
-- hi default link DapUIValue Normal
-- hi default link DapUICurrentFrameName DapUIBreakpointsCurrentLine
-- hi default link DapUIEndofBuffer EndofBuffer
-- hi default link DapUIBreakpointsLine DapUILineNumber
-- hi default DapUIScope                   guifg=#00F1F5
-- hi default DapUIType                    guifg=#D484FF
-- hi default DapUIModifiedValue           guifg=#00F1F5 gui=bold
-- hi default DapUIDecoration              guifg=#00F1F5
-- hi default DapUIThread                  guifg=#A9FF68
-- hi default DapUIStoppedThread           guifg=#00f1f5
-- hi default DapUISource                  guifg=#D484FF
-- hi default DapUILineNumber              guifg=#00f1f5
-- hi default DapUIFloatBorder             guifg=#00F1F5
-- hi default DapUIWatchesEmpty            guifg=#F70067
-- hi default DapUIWatchesValue            guifg=#A9FF68
-- hi default DapUIWatchesError            guifg=#F70067
-- hi default DapUIBreakpointsPath         guifg=#00F1F5
-- hi default DapUIBreakpointsInfo         guifg=#A9FF68
-- hi default DapUIBreakpointsCurrentLine  guifg=#A9FF68 gui=bold
-- hi default DapUIBreakpointsDisabledLine guifg=#424242
-- hi default DapUIStepOver                guifg=#00f1f5
-- hi default DapUIStepInto                guifg=#00f1f5
-- hi default DapUIStepBack                guifg=#00f1f5
-- hi default DapUIStepOut                 guifg=#00f1f5
-- hi default DapUIStop                    guifg=#F70067
-- hi default DapUIPlayPause               guifg=#A9FF68
-- hi default DapUIRestart                 guifg=#A9FF68
-- hi default DapUIUnavailable             guifg=#424242
-- hi default DapUIWinSelect ctermfg=Cyan  guifg=#00f1f5 gui=bold