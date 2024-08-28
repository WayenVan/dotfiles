-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_augroup("AutoSourceNvimLua", { clear = true })
vim.api.nvim_create_augroup("ToggleTerm", { clear = true })
vim.api.nvim_create_augroup("UserStorage", { clear = true })

-- Create an autocommand to run when entering a directory
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  group = "AutoSourceNvimLua",
  callback = function()
    require("utils.file").auto_source()
  end,
})

-- Close all git terminals when session closes
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  group = "ToggleTerm",
  callback = function()
    require("utils.term").clear_storage()
  end,
})

-- save storage when exiting
vim.api.nvim_create_autocmd({ "QuitPre" }, {
  group = "UserStorage",
  callback = function()
    require("utils.storage").save_storage(UserStorage)
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufFilePost" }, {
  callback = function()
    -- local buf_type = vim.bo.buftype
    -- if buf_type == "" then
    --   vim.opt_local.winbar = "%f"
    -- end
  end,
})
