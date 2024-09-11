-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- using powershell setting
if LazyVim.is_win() then
  -- refered from toggleterm.nvim
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }
  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
else
  if vim.fn.executable("fish") then
    vim.o.shell = "fish"
    vim.o.shellcmdflag = "-c"
    vim.o.shellquote = ""
    vim.o.shellxquote = ""
  elseif vim.fn.executable("zsh") then
    -- fallback to zshell
    vim.o.shell = "zsh"
    vim.o.shellcmdflag = "-c"
    vim.o.shellquote = "'"
    vim.o.shellxquote = ""
  end
end

-- local misc = require("utils.misc")

-- sessiont setting
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

-- clipboard
vim.opt.clipboard = ""
-- vim.opt.winbar = "%f"

vim.opt.mouse = "a"

-- add errorformat
if LazyVim.is_win() then
  -- vim.opt.errorformat:append({
  --   -- for python
  --   '%A %#File "%f"\\, line %l\\, in %o,%Z %#%m',
  -- })
else
  -- vim.opt.errorformat:append({
  --   -- for python
  --   -- [[.*File\ \"%f\"\,\ line %l\, in %o]]
  --   -- [[*File\ \"\"\,\ line l\, in o]]
  --   [[hahha]]
  -- })
  -- vim.opt.errorformat = '%A%.%#File "%f"\\, line %l\\, in %o,%Z %#%m'
end

-- set pyright to basedpyright
vim.g.lazyvim_python_lsp = "basedpyright"
-- guifont
vim.o.guifont = "JetBrainsMono Nerd Font:h14"
