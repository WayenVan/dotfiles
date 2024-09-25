return {
  {
    "rebelot/heirline.nvim",
    enabled = false,
    dependencies = { "Zeioth/heirline-components.nvim" },
    opts = function(_, opts)
      local lib = require("heirline-components.all").component
      local hl_status = vim.api.nvim_get_hl(0, { name = "StatusLine" })
      local fg_color = string.format("#%06x", hl_status.bg)
      local conditions = require("heirline.conditions")
      return {
        statusline = {
          -- lib.mode(),
          -- lib.git_branch(),
          -- lib.file_info(),
          {
            condition = conditions.lsp_attached,
            update = { "LspAttach", "LspDetach" },

            -- You can keep it simple,
            -- provider = " [LSP]",

            -- Or complicate things a bit and get the servers names
            provider = function()
              local names = {}
              for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                table.insert(names, server.name)
              end
              return " [" .. table.concat(names, " ") .. "]"
            end,
            hl = { fg = "orange", bold = true, bg = fg_color },
          },
        },
      }
    end,
    config = function(_, opts)
      local heirline = require("heirline")
      local heirline_components = require("heirline-components.all")

      -- Setup
      heirline_components.init.subscribe_to_events()
      heirline.load_colors(heirline_components.hl.get_colors())
      heirline.setup(opts)
    end,
  },
}
