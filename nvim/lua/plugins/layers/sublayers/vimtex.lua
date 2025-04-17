LayersManager.layers.VIMTEX = Layers.mode.new("Vimtex Layer")
local vimtex_layer = LayersManager.layers.VIMTEX
vimtex_layer:keymaps({
  n = {
    { "<localleader>i", "<plug>(vimtex-info)        ", { desc = "vimtex-info" } },
    { "<localleader>I", "<plug>(vimtex-info-full)   ", { desc = "vimtex-info-full" } },
    { "<localleader>t", "<plug>(vimtex-toc-open)    ", { desc = "vimtex-toc-open" } },
    { "<localleader>T", "<plug>(vimtex-toc-toggle)  ", { desc = "vimtex-toc-toggle" } },
    { "<localleader>q", "<plug>(vimtex-log)         ", { desc = "vimtex-log" } },
    { "<localleader>v", "<plug>(vimtex-view)        ", { desc = "vimtex-view" } },
    { "<localleader>r", "<plug>(vimtex-reverse-search)", { desc = "vimtex-reverse-search" } },
    { "<localleader>l", "<plug>(vimtex-compile)     ", { desc = "vimtex-compile" } },
    { "<localleader>L", "<plug>(vimtex-compile-selected)", { desc = "vimtex-compile-selected" } },
    { "<localleader>k", "<plug>(vimtex-stop)        ", { desc = "vimtex-stop" } },
    { "<localleader>K", "<plug>(vimtex-stop-all)    ", { desc = "vimtex-stop-all" } },
    { "<localleader>e", "<plug>(vimtex-errors)      ", { desc = "vimtex-errors" } },
    { "<localleader>o", "<plug>(vimtex-compile-output)", { desc = "vimtex-compile-output" } },
    { "<localleader>g", "<plug>(vimtex-status)      ", { desc = "vimtex-status" } },
    { "<localleader>G", "<plug>(vimtex-status-all)  ", { desc = "vimtex-status-all" } },
    { "<localleader>c", "<plug>(vimtex-clean)       ", { desc = "vimtex-clean" } },
    { "<localleader>C", "<plug>(vimtex-clean-full)  ", { desc = "vimtex-clean-full" } },
    { "<localleader>m", "<plug>(vimtex-imaps-list)  ", { desc = "vimtex-imaps-list" } },
    { "<localleader>x", "<plug>(vimtex-reload)      ", { desc = "vimtex-reload" } },
    { "<localleader>X", "<plug>(vimtex-reload-state)", { desc = "vimtex-reload-state" } },
    { "<localleader>s", "<plug>(vimtex-toggle-main) ", { desc = "vimtex-toggle-main" } },
    { "<localleader>a", "<plug>(vimtex-context-menu)", { desc = "vimtex-context-menu" } },
    {
      "<C-q>",
      function()
        LayersManager:deactivate("VIMTEX")
      end,
      { desc = "exit" },
    },
  },
})

local vim_tex_layer_autcmds = vim.api.nvim_create_augroup("vim_tex_layer_autcmds", { clear = true })
-- vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
--   group = vim_tex_layer_autcmds,
--   callback = function()
--     if idx ~= nil then
--       return
--     end
--
--     local buf = vim.api.nvim_win_get_buf(0) -- Get buffer of leaving window
--     local filetype = vim.bo[buf].filetype
--     if filetype == "tex" or filetype == "bib" then
--       vimtex_layer:activate()
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd("BufLeave", {
--   group = vim_tex_layer_autcmds,
--   callback = function(args)
--     local filetype = vim.bo[args.buf].filetype
--     if filetype == "tex" or filetype == "bib" then
--       -- vim.notify("Left a LaTeX buffer", vim.log.levels.INFO)
--       if idx ~= nil then
--         vimtex_layer:deactivate()
--       end
--     end
--   end,
-- })
