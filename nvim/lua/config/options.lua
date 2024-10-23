-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- setting the powershell settings
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
  local shell = vim.fn.getenv("SHELL")
  if shell then
    vim.opt.shell = shell
  else
    vim.opt.shell = "/bin/sh"
    vim.notify("SHELL environment variable is not set", vim.log.levels.WARN)
  end

  vim.o.shellcmdflag = "-c"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
  -- if vim.fn.executable("fish") then
  --   vim.o.shell = "fish"
  --   vim.o.shellcmdflag = "-c"
  --   vim.o.shellquote = ""
  --   vim.o.shellxquote = ""
  -- elseif vim.fn.executable("zsh") then
  --   -- fallback to zshell
  --   vim.o.shell = "zsh"
  --   vim.o.shellcmdflag = "-c"
  --   vim.o.shellquote = "'"
  --   vim.o.shellxquote = ""
  -- end
end

-- sessiont setting
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

-- set pyright to basedpyright
vim.g.lazyvim_python_lsp = "basedpyright"
-- guifont
vim.o.guifont = "JetBrainsMono Nerd Font:h14"

if require("utils.os_name").get_os_name() == "Windows" then
  vim.o.shada = "!,'100,<50,s10,h,rA:,rB:"
else
  vim.o.shada = "!,'100,<50,s10,h"
end

-- auto cmds before and in LazyVim
-- for setting up custmozed command in vim enter
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "VeryLazy",
  callback = function()
    vim.filetype.add({
      filename = {
        [".condarc"] = "yaml", -- Set filetype to 'python' for a file named 'mycustomfile'
        [".fishrc"] = "fish",
      },
      extension = {},
      pattern = {},
    })
    require("utils.server").setup()
  end,
  once = true,
})

-- load customized cmds
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "VeryLazy",
  callback = function()
    require("config.cmds")
  end,
  once = true,
})

-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = "LazyFile",
--   callback = function()
--     vim.opt.background = "light"
--   end,
--   once = true,
-- })
