-- print(vim.inspect(vim.opt.errorformat))
--
-- print(vim.inspect(vim.opt.errorformat:get()))
-- %A %#File "%f"\, line %l\, in %o,%Z %#%m
--
--
local client = vim.lsp.get_client_by_id(3)
local cap = client.capabilities

print(vim.inspect(cap))
