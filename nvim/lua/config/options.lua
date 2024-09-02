-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- shell setting
if LazyVim.is_win() then
  -- Set PowerShell as the default shell
  vim.o.shell = "powershell"
  vim.o.shellcmdflag = "-command"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
end

-- local misc = require("utils.misc")

-- sessiont setting
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- clipboard
vim.opt.clipboard = ""
-- vim.opt.winbar = "%f"

vim.opt.mouse = "a"
