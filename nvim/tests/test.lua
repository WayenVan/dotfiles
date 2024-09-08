-- print(vim.inspect(vim.opt.errorformat))
--
-- print(vim.inspect(vim.opt.errorformat:get()))
-- %A %#File "%f"\, line %l\, in %o,%Z %#%m
--
--
local result = vim.fn.system("Get-Command python | Select-Object -ExpandProperty Path")
-- print(result)

-- local nls = require("null-ls").builtins.diagnostics.mypy

local nls = require("plugins.lsp.servers.none-ls-cfg.mypy-diagnostics")
-- print(vim.inspect(nsl._opts._last_args))

for k, v in pairs(nls) do
  print(k, vim.inspect(v))
end
