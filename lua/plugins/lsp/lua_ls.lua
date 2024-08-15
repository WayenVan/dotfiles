return {
  -- mason = false, -- set to false if you don't want this server to be installed with mason
  -- Use this to add any additional keymaps
  -- for specific lsp servers
  -- ---@type LazyKeysSpec[]
  -- keys = {},
  root_dir = function(fname)
    local util = require("lspconfig").util
    local root_parttern = {
      ".git/",
      "init.lua",
      "package.json",
      ".neoconf.json",
    }
    return util.root_pattern(unpack(root_parttern))(fname) or nil
  end,
  -- settings = {
  --   Lua = {
  --     workspace = {
  --       checkThirdParty = false,
  --     },
  --     codeLens = {
  --       enable = true,
  --     },
  --     completion = {
  --       callSnippet = "Replace",
  --     },
  --     doc = {
  --       privateName = { "^_" },
  --     },
  --     hint = {
  --       enable = true,
  --       setType = false,
  --       paramType = true,
  --       paramName = "Disable",
  --       semicolon = "Disable",
  --       arrayIndex = "Disable",
  --     },
  --   },
  -- },
}
