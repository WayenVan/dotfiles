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
            -- client.server_capabilities.inlayHintProvider = nil
            -- disable complement for ty becasue of conflict with pyright
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.completionProvider = nil
            client.server_capabilities.signatureHelpProvider = nil
            client.server_capabilities.documentSymbolProvider = nil
            client.server_capabilities.definitionProvider = false
            -- client:stop()
          end, "ty")

          vim.lsp.enable("ty")

          -- NOTE: we stop the setting from the lspconfig by this
          return true
        end,
        pyrefly = function(_, opts)
          vim.lsp.config("pyrefly", opts)

          LazyVim.lsp.on_attach(function(client, bufnr)
            -- client.server_capabilities.definitionProvider = false
            -- Disable some feature becuase it is provided by
            -- client.server_capabilities.hoverProvider = false
            -- disable complement for tyrefly becasue of conflict with pyright
            client.server_capabilities.inlayHintProvider = nil
            client.server_capabilities.diagnosticProvider = nil
            -- client.server_capabilities.completionProvider = nil
            -- client:stop()
          end, "pyrefly")

          vim.lsp.enable("pyrefly")

          -- NOTE: we stop the setting from the lspconfig by this
          return true
        end,
        pyright = function(_, opts)
          LazyVim.lsp.on_attach(function(client, bufnr)
            -- Disable some feature becuase it is provided by
            -- client.server_capabilities.hoverProvider = false
            -- client.server_capabilities.inlayHintProvider = nil
            client.server_capabilities.diagnosticProvider = nil
            client.server_capabilities.definitionProvider = nil
            client.server_capabilities.declarationProvider = nil
            client.server_capabilities.typeDefinitionProvider = nil
            client.server_capabilities.documentSymbolProvider = nil
            -- client.server_capabilities.completionProvider = nil
          end, "pyright")
          return false
        end,
      },
      servers = {
        ty = {
          cmd = { "ty", "server" },
          filetypes = { "python" },
          root_markers = { "pyproject.toml", "ty.toml", ".git" },
          -- init_options = {
          --   settings = {
          --     python = {
          --       ty = {
          --         disableLanguageServices = true, -- Disable type errors
          --       },
          --     },
          --   },
          -- },
          enabled = true, -- Disable ty by default
          mason = false,
        },
        pyrefly = {
          cmd = { "pyrefly", "lsp" },
          filetypes = { "python" },
          root_markers = {
            "pyrefly.toml",
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            ".git",
          },
          settings = {
            -- python.pyrefly.disableTypeErrors
            python = {
              pyrefly = {
                disableTypeErrors = "force-off",
              },
            },
          },
          enabled = true,
          mason = false,
        },
        pyright = {
          enabled = false, -- Disable pyright by default
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- Disable type checking
                useLibraryCodeForTypes = false, -- Use library code for types
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
