return {
  {
    "Bekaboo/dropbar.nvim",
    -- enabled = false,
    -- dropbar only provide source for lualine
    -- event = "VeryLazy",
    lazy = true,
    opts = {
      bar = {
        enabled = false,
        sources = function(buf, _)
          local sources = require("dropbar.sources")
          local utils = require("dropbar.utils")
          if vim.bo[buf].ft == "markdown" then
            return {
              sources.path,
              sources.markdown,
            }
          end
          if vim.bo[buf].buftype == "terminal" then
            return {
              sources.terminal,
            }
          end
          return {
            -- sources.path,
            utils.source.fallback({
              sources.lsp,
              sources.treesitter,
            }),
          }
        end,
      },
      menu = {
        enabled = false,
        preview = false,
        win_configs = {
          border = "none",
        },
      },
    },
    config = function(_, opts)
      local valid_types = require("dropbar.configs").opts.sources.treesitter.valid_types

      for i, t in ipairs(valid_types) do
        if t == "module" then
          table.remove(valid_types, i)
          break
        end
      end
      require("dropbar").setup(opts)
    end,
  },
}
