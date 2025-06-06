-- this setting override the default setting from LazyVim
-- vim.fn.exepath("pythhon") get python path
-- set pyright to basedpyright
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      --@type lspconfig.options
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true, -- Using Ruff
              disableTaggedHints = true, -- Using Ruff
              analysis = {
                typeCheckingMode = "off", -- Disable type checking
                useLibraryCodeForTypes = true, -- Use library code for types
              },
            },
          },
        },
      },
    },
  },
}
