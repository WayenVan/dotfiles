-- print(vim.inspect(vim.opt.errorformat))
-- print(vim.opt.errorformat._value)

require("neotest").run.run("tests/test_demo.py")
--
-- print(vim.inspect(vim.opt.errorformat:get()))
-- %A %#File "%f"\, line %l\, in %o,%Z %#%m
--
-- local result = vim.fn.system("which python3")
-- print(vim.inspect(result))

-- local nls = require("null-ls").builtins.diagnostics.mypy

-- local nls = require("plugins.lsp.servers.none-ls-cfg.mypy-diagnostics")
-- print(vim.inspect(nsl._opts._last_args))

-- for k, v in pairs(nls) do
--   print(k, vim.inspect(v))
-- end
--
-- local info, _ = require("utils.python")
-- if info == nil then
--   return
--
-- end
-- print(vim.inspect(info))
-- print(vim.inspect(LazyVim.config.kind_filter))
