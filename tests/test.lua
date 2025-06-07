local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

vim.notify(vim.inspect(all_mslp_servers))

local is_in = vim.tbl_contains(all_mslp_servers, "ty")
vim.notify(is_in)
