-- WARN: deprecated due to change to runs
local submode = require("submode")
-- a cross-mode layers for REPL
_G.submode_repl = {
  activated = false,
  enter = function()
    _G.submode_repl.activated = true
    local current_mode = vim.fn.mode()
    if current_mode == "n" then
      submode.enter("Repl")
    end
    if current_mode == "v" then
      submode.enter("V-Repl")
    end
  end,
  leave = function()
    if _G.submode_repl.activated then
      if submode.mode() == "Repl" or submode.mode() == "V-Repl" then
        submode.leave()
      end
      _G.submode_repl.activated = false
    end
  end,
}
vim.keymap.set("n", "<leader>$", function()
  _G.submode_repl.enter()
end, { desc = "Enter REPL Mode" })
local repl_submod_cmd_group = vim.api.nvim_create_augroup("repl_submod_cmd_group", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
  group = repl_submod_cmd_group,
  pattern = "*:*[vV]",
  callback = function()
    if _G.submode_repl.activated then
      submode.enter("V-Repl")
    end
  end,
})
vim.api.nvim_create_autocmd("ModeChanged", {
  group = repl_submod_cmd_group,
  pattern = "*:*n",
  callback = function()
    if _G.submode_repl.activated then
      submode.enter("Repl")
    end
  end,
})
vim.api.nvim_create_autocmd("User", {
  group = repl_submod_cmd_group,
  pattern = "SubmodeEnterPre", -- Name of user events
  callback = function(env)
    if _G.submode_repl.activated then
      if env.data.name ~= "Repl" and env.data.name ~= "V-Repl" then
        _G.submode_repl.leave()
      end
    end
  end,
})
submode.create("Repl", {
  mode = "n",
  default = function(register)
    -- scope
    register("<localleader>s", function()
      local w = require("dap.ui.widgets")
      -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
      w.centered_float(w.scopes)
    end, { desc = "Dap Scopes" })
    register("<localleader>$", "", {
      desc = "+ REPL",
    })
    register("<localleader>f", "<CMD>REPLFocus<CR>", {
      desc = "Focus on REPL",
    })
    register("<localleader>s", "<CMD>Telescope REPLShow<CR>", {
      desc = "View REPLs in telescope",
    })
    register("<localleader>h", "<CMD>REPLHide<CR>", {
      desc = "Hide REPL",
    })
    register("<localleader>r", "<CMD>REPLSendVisual<CR>", {
      desc = "Send visual region to REPL",
    })
    register("<localleader>r", "<CMD>REPLSendLine<CR>", {
      desc = "Send line to REPL",
    })
    register("<localleader>o", "<CMD>REPLSendOperator<CR>", {
      desc = "Send current line to REPL",
    })
    register("<localleader>q", "<CMD>REPLClose<CR>", {
      desc = "Quit REPL",
    })
    register("<localleader>Q", "<CMD>REPLDeleteALL<CR>", {
      desc = "Forcequit all REPLs",
    })
    register("<localleader>Q", function()
      vim.cmd("REPLDeleteALL")
      _G.submode_repl.leave()
    end, {
      desc = "Forcequit all REPLs",
    })
    register("<localleader>c", "<CMD>REPLCleanup<CR>", {
      desc = "Clear REPLs.",
    })
    register("<localleader>S", "<CMD>REPLSwap<CR>", {
      desc = "Swap REPLs.",
    })
    register("<localleader>a", "<CMD>REPLStart<CR>", {
      desc = "Start an REPL from available REPL metas",
    })
    register("<localleader>A", "<CMD>REPLAttachBufferToREPL<CR>", {
      desc = "Attach current buffer to a REPL",
    })
    register("<localleader>d", "<CMD>REPLDetachBufferToREPL<CR>", {
      desc = "Detach current buffer to any REPL",
    })
    register("<C-Q>", _G.submode_repl.leave, {
      desc = "Exit REPL",
    })
    -- scope
    submode.create("V-Repl", {
      mode = "v",
      default = function(register)
        register("<localleader>r", "<CMD>REPLSendVisual<CR>", {
          desc = "Send visual region to REPL",
        })
        register("<C-Q>", _G.submode_repl.leave, {
          desc = "Exit REPL",
        })
      end,
      -- keymap = { "q", "<Esc>", "<C-c>", "<C-d>", "d", "D", "x" },
    })
  end,
})
