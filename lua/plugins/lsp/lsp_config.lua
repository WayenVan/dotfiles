return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "ray-x/lsp_signature.nvim" },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      -- servers = require("plugins.lsp.servers"),
      servers = {
        lua_ls = require("plugins.lsp.servers.lua_ls"),
      },
    },
  },
}
