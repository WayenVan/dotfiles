local submode = require("submode")
-- debug submode
vim.keymap.set("n", "<leader>%", function()
  submode.enter("Tex")
end, { desc = "Enter tex mode " })
submode.create("Tex", {
  mode = "n",
  enter = nil,
  leave = { "<C-q>" },
  default = function(register)
    register("<localleader>i", "<plug>(vimtex-info)        ", { desc = "vimtex-info" })
    register("<localleader>I", "<plug>(vimtex-info-full)   ", { desc = "vimtex-info-full" })
    register("<localleader>t", "<plug>(vimtex-toc-open)    ", { desc = "vimtex-toc-open" })
    register("<localleader>T", "<plug>(vimtex-toc-toggle)  ", { desc = "vimtex-toc-toggle" })
    register("<localleader>q", "<plug>(vimtex-log)         ", { desc = "vimtex-log" })
    register("<localleader>v", "<plug>(vimtex-view)        ", { desc = "vimtex-view" })
    register("<localleader>r", "<plug>(vimtex-reverse-search)", { desc = "vimtex-reverse-search" })
    register("<localleader>l", "<plug>(vimtex-compile)     ", { desc = "vimtex-compile" })
    register("<localleader>L", "<plug>(vimtex-compile-selected)", { desc = "vimtex-compile-selected" })
    register("<localleader>k", "<plug>(vimtex-stop)        ", { desc = "vimtex-stop" })
    register("<localleader>K", "<plug>(vimtex-stop-all)    ", { desc = "vimtex-stop-all" })
    register("<localleader>e", "<plug>(vimtex-errors)      ", { desc = "vimtex-errors" })
    register("<localleader>o", "<plug>(vimtex-compile-output)", { desc = "vimtex-compile-output" })
    register("<localleader>g", "<plug>(vimtex-status)      ", { desc = "vimtex-status" })
    register("<localleader>G", "<plug>(vimtex-status-all)  ", { desc = "vimtex-status-all" })
    register("<localleader>c", "<plug>(vimtex-clean)       ", { desc = "vimtex-clean" })
    register("<localleader>C", "<plug>(vimtex-clean-full)  ", { desc = "vimtex-clean-full" })
    register("<localleader>m", "<plug>(vimtex-imaps-list)  ", { desc = "vimtex-imaps-list" })
    register("<localleader>x", "<plug>(vimtex-reload)      ", { desc = "vimtex-reload" })
    register("<localleader>X", "<plug>(vimtex-reload-state)", { desc = "vimtex-reload-state" })
    register("<localleader>s", "<plug>(vimtex-toggle-main) ", { desc = "vimtex-toggle-main" })
    register("<localleader>a", "<plug>(vimtex-context-menu)", { desc = "vimtex-context-menu" })
  end,
})
local tex_submode_cmd_group = vim.api.nvim_create_augroup("tex_submode_cmd_group", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  group = tex_submode_cmd_group,
  callback = function()
    local buf = vim.api.nvim_win_get_buf(0) -- Get buffer of leaving window
    local filetype = vim.bo[buf].filetype
    if filetype == "tex" or filetype == "bib" then
      submode.enter("Tex")
    end
  end,
})
vim.api.nvim_create_autocmd("BufLeave", {
  group = tex_submode_cmd_group,
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    if filetype == "tex" or filetype == "bib" then
      -- vim.notify("Left a LaTeX buffer", vim.log.levels.INFO)
      if submode.mode() == "Tex" then
        submode.leave()
      end
    end
  end,
})
