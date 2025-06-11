-- this setting override the default setting from LazyVim
-- vim.fn.exepath("pythhon") get python path
-- set pyright to basedpyright
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      --@type lspconfig.options
      setup = {},
      servers = {
        texlab = {
          -- enabled = false, -- Disable texlab by default
          settings = {
            texlab = {
              inlayHints = {
                labelReferences = false,
                labelDefinitions = false,
              },
            },
          },
        },
      },
    },
  },
}
