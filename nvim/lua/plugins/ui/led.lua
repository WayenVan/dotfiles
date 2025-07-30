return {
  {
    "joaomendoncaa/led.nvim",

    -- This is optional, but recommended for load time performance
    event = "VeryLazy",

    -- You can use opts or the normal config function with `require("led").setup(opts)`
    opts = {
      -- Default LED configuration (always present, shows when buffer is modified)
      char = "*", -- Character to display
      position = "top-right", -- Position: "top-right", "top-left", "bottom-right", "bottom-left", "top-center", "bottom-center"
      order = 3, -- Order within same position (lower = closer to edge/center)
      highlight = { link = "WarningMsg" }, -- Color configuration
      ignore = { -- Buffer/file types to ignore
        "help",
        "terminal",
        "quickfix",
        "nofile",
        "snacks_notif",
        "snacks_notif_history",
        "NvimTree",
        "noice",
      },
      debug = false, -- Enable debug logging

      -- Custom LEDs (optional examples)
      leds = {
        -- Error count LED
        -- {
        --   position = "top-right", -- Optional: inherits from default if not set
        --   order = 2, -- Optional: auto-assigned if not set
        --   highlight = { fg = "#ff0000", bg = "NONE" }, -- Optional: inherits from default if not set
        --   ignore = {}, -- Optional: inherits from default if not set
        --   handler = function(winnr, bufnr) -- Required: function that returns string/boolean/nil
        --     local errors = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
        --     if errors == 0 then
        --       return nil
        --     end
        --     return "E" .. tostring(errors)
        --   end,
        -- },
        {
          position = "top-right",
          highlight = { link = "NormalFloat" },
          order = 1,
          handler = function(winnr, bufnr)
            local full_path = vim.api.nvim_buf_get_name(bufnr)
            if full_path == "" then
              return nil
            end

            local parent_dir = vim.fn.fnamemodify(full_path, ":h:t")
            local filename = vim.fn.fnamemodify(full_path, ":t")

            return parent_dir .. "/" .. filename
          end,
        },
        {
          position = "top-right",
          highlight = { link = "WarningMsg" },
          handler = function(winnr, bufnr)
            return vim.bo[bufnr].readonly and "🔒" or nil
          end,
        },

        -- TODO count LED
        -- {
        --   position = "top-right",
        --   order = 3,
        --   highlight = { fg = "#ffff00", bg = "NONE" },
        --   handler = function(winnr, bufnr)
        --     local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        --     local todo_count = 0
        --     for _, line in ipairs(lines) do
        --       if line:match("TODO") then
        --         todo_count = todo_count + 1
        --       end
        --     end
        --
        --     if todo_count == 0 then
        --       return nil
        --     end
        --     return "☰" .. tostring(todo_count)
        --   end,
        -- },
      },
    },
  },
}
