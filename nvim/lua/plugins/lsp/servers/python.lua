-- this setting override the default setting from LazyVim
-- vim.fn.exepath("pythhon") get python path
-- set pyright to basedpyright
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- #NOTE: currently ty is not supported by mason-lspconfig
      --@type lspconfig.options
      setup = {
        ty = function(_, opts)
          vim.lsp.config("ty", opts)

          LazyVim.lsp.on_attach(function(client, bufnr)
            -- Disable some feature becuase it is provided by
            client.server_capabilities.hoverProvider = false
            -- client:stop()
          end, "ty")

          vim.lsp.enable("ty")
          -- NOTE: we stop the setting from the lspconfig by this
          return true
        end,
      },
      servers = {
        ty = {
          cmd = { "ty", "server" },
          filetypes = { "python" },
          root_markers = { "pyproject.toml", "ty.toml", ".git" },
          init_options = {
            ty = {
              experimental = {
                completions = {
                  enable = true, -- Enable completions
                },
              },
            },
          },
          enabled = true,
          mason = false,
        },
        pyright = {
          enabled = true, -- Disable pyright by default
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- Disable type checking
                useLibraryCodeForTypes = true, -- Use library code for types
              },
            },
            pyright = {
              disableOrganizeImports = true, -- Using Ruff
              disableTaggedHints = true, -- Using Ruff
            },
          },
        },
        basedpyright = {
          enabled = false, -- Disable basedpyright by default
          settings = {
            basedpyright = {
              disableOrganizeImports = true, -- Using Ruff
              disableTaggedHints = true, -- Using Ruff
              analysis = {
                inlayHints = {
                  functionReturnTypes = false, -- Enable function return types in inlay hints
                },
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
