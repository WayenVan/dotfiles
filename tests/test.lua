local logger = require("logger")

local all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

local is_in = vim.tbl_contains(all_mslp_servers, "ty")
