LayersManager.layers.REPL = Layers.mode.new("REPL Layer")
local repl_layer = LayersManager.layers.REPL
repl_layer:auto_show_help()
-- repl_layer.window.config.width = nil
repl_layer:keymaps({
  n = {
    -- scope
    {
      "<localleader>s",
      function()
        local w = require("dap.ui.widgets")
        -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
        w.centered_float(w.scopes)
      end,
      { desc = "Dap Scopes" },
    },
    { "<localleader>$", "", {
      desc = "+ REPL",
    } },
    { "<localleader>f", "<CMD>REPLFocus<CR>", {
      desc = "Focus on REPL",
    } },
    { "<localleader>s", "<CMD>Telescope REPLShow<CR>", {
      desc = "View REPLs in telescope",
    } },
    { "<localleader>h", "<CMD>REPLHide<CR>", {
      desc = "Hide REPL",
    } },
    { "<localleader>r", "<CMD>REPLSendVisual<CR>", {
      desc = "Send visual region to REPL",
    } },
    { "<localleader>r", "<CMD>REPLSendLine<CR>", {
      desc = "Send line to REPL",
    } },
    { "<localleader>o", "<CMD>REPLSendOperator<CR>", {
      desc = "Send current line to REPL",
    } },
    { "<localleader>q", "<CMD>REPLClose<CR>", {
      desc = "Quit REPL",
    } },
    { "<localleader>Q", "<CMD>REPLDeleteALL<CR>", {
      desc = "Forcequit all REPLs",
    } },
    {
      "<localleader>Q",
      function()
        vim.cmd("REPLDeleteALL")
        LayersManager:deactivate("REPL")
      end,
      {
        desc = "Forcequit all REPLs",
      },
    },
    { "<localleader>c", "<CMD>REPLCleanup<CR>", {
      desc = "Clear REPLs.",
    } },
    { "<localleader>S", "<CMD>REPLSwap<CR>", {
      desc = "Swap REPLs.",
    } },
    { "<localleader>a", "<CMD>REPLStart<CR>", {
      desc = "Start an REPL from available REPL metas",
    } },
    { "<localleader>A", "<CMD>REPLAttachBufferToREPL<CR>", {
      desc = "Attach current buffer to a REPL",
    } },
    {
      "<localleader>d",
      "<CMD>REPLDetachBufferToREPL<CR>",
      {
        desc = "Detach current buffer to any REPL",
      },
    },
    {
      "<leader>$",
      function()
        LayersManager:deactivate("REPL")
      end,
      {
        desc = "Exit REPL",
      },
    },
  },
  v = {
    { "<localleader>r", "<CMD>REPLSendVisual<CR>", {
      desc = "Send visual region to REPL",
    } },
  },
})
