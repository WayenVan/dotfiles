return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "meuter/lualine-so-fancy.nvim",
      "DaikyXendo/nvim-material-icon",
    },
    -- enabled = false,
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {

          component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = {
            statusline = {
              "dashboard",
              "snacks_dashboard",
              "alpha",
              "ministarter",
              "TelescopePrompt",
              "snacks_picker_input",
            },
          },
        },
        sections = {
          lualine_a = {
            "mode",
            -- {
            --   "_submode",
            --   cond = function()
            --     return require("submode").mode() ~= nil
            --   end,
            -- },
            { "_submode_status" },
            { "_layers_status" },
          },
          lualine_b = {
            "branch",
          },

          lualine_c = {
            { "fancy_cwd", substitute_home = true, separator = "" },
            -- LazyVim.lualine.root_dir(),
            -- { "filesize", padding = { left = 0, right = 1 } },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            -- { LazyVim.lualine.pretty_path() },
            -- stylua: ignore
            "overseer",
            -- stylua: ignore
            -- "harpoon2",
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
          },
          lualine_x = {
            Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            -- lazy updates
            -- {
            --   require("lazy.status").updates,
            --   cond = require("lazy.status").has_updates,
            --   color = function()
            --     return LazyVim.ui.fg("Special")
            --   end,
            -- },
            { "fancy_filetype", ts_icon = "" },
            -- { "fancy_lsp_servers" },
            { "_lsp_servers" },
            -- stylua: ignore
            { "_location" },
          },
          lualine_y = {
            -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
            -- { "location", padding = { left = 0, right = 1 } },
            { "filename" },
          },
          lualine_z = {
            { "fileformat", padding = { left = 1, right = 1 } },
            { "encoding", padding = { left = -1, right = 1 } },
            -- { "fancy_location" },
            -- {
            --   function()
            --     return " " .. os.date("%R")
            --   end,
            --   separator = "|",
            -- },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      -- if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      --   local trouble = require("trouble")
      --   local symbols = trouble.statusline({
      --     mode = "symbols",
      --     groups = {},
      --     title = false,
      --     filter = { range = true },
      --     format = "{kind_icon}{symbol.name:Normal}",
      --     hl_group = "lualine_c_normal",
      --   })
      --   table.insert(opts.sections.lualine_c, {
      --     symbols and symbols.get,
      --     cond = function()
      --       return vim.b.trouble_lualine ~= false and symbols.has()
      --     end,
      --   })
      -- end

      return opts
    end,
  },
}
