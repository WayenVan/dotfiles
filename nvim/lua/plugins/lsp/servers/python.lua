-- this setting override the default setting from LazyVim
local function get_python_executable()
  local result = vim.fn.system("Get-Command python | Select-Object -ExpandProperty Path")
  return vim.fn.substitute(result, "\n", "", "")
end

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      --@type lspconfig.options
      servers = {
        -- do not use pyright
        pyright = {
          -- enabled = false,
          settings = {
            pyright = {
              disableOrganizeImports = true, -- Using Ruff
            },
            python = {
              analysis = {
                ignore = { "*" }, -- Using Ruff
                typeCheckingMode = "off", -- Using mypy
              },
            },
          },
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local python_executable = get_python_executable()
      local null = require("null-ls")
      local h = require("null-ls.helpers")
      local u = require("null-ls.utils")
      local mypy = null.builtins.diagnostics.mypy.with({
        args = function(params)
          return {
            "--hide-error-codes",
            "--hide-error-context",
            "--no-color-output",
            "--show-absolute-path",
            "--show-column-numbers",
            "--show-error-codes",
            "--no-error-summary",
            "--no-pretty",
            "--shadow-file",
            params.bufname,
            params.temp_path,
            "--python-executable",
            python_executable,
            params.bufname,
          }
        end,
        cwd = h.cache.by_bufnr(function(params)
          return u.root_pattern(
            -- https://mypy.readthedocs.io/en/stable/config_file.html
            "mypy.ini",
            ".mypy.ini",
            "pyproject.toml",
            "setup.cfg",
            "setup.py",
            ".git/",
            "neoconf.json",
            ".neoconf.json"
          )(params.bufname)
        end),
        -- only on save
        method = null.methods.DIAGNOSTICS_ON_SAVE,
        diagnostic_config = {
          underline = false,
        },
      })
      opts.sources = vim.list_extend(opts.sources or {}, {
        mypy,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "mypy",
      },
    },
  },
}
