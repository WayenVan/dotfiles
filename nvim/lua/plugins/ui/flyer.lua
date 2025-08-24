return {
  {
    "WayenVan/fyler.nvim",
    -- dir = "~/Desktop/forked/fyler.nvim",
    branch = "feature/multi_tabs_support",
    -- dependencies = { "echasnovski/mini.icons" },
    enabled = true,
    dependencies = { "DaikyXendo/nvim-material-icon" },
    -- branch = "stable",
    keys = {
      {
        "<leader>r",
        function()
          require("fyler").open({ enter = false })
        end,
        desc = "Open Fyler Explorer",
      },
      {
        "<leader>f.",
        function()
          require("fyler").track_buffer()
        end,
        desc = "track current buffer in Fyler",
      },
    },
    opts = {
      mappings = {
        explorer = {
          ---@param view FylerExplorerView
          ["Y"] = function(view)
            local algos = require("fyler.views.explorer.algos")
            local store = require("fyler.views.explorer.store")
            local api = vim.api
            local itemid = algos.match_itemid(api.nvim_get_current_line())
            if not itemid then
              return
            end
            local entry = store.get_entry(itemid)
            -- vim.notify(vim.inspect(entry))
            require("utils.yank_path").yank_path_picker(entry.path)
          end,
          ["<localleader>f"] = function(view)
            local algos = require("fyler.views.explorer.algos")
            local store = require("fyler.views.explorer.store")
            local api = vim.api
            local itemid = algos.match_itemid(api.nvim_get_current_line())
            if not itemid then
              return
            end
            local entry = store.get_entry(itemid)
            local current_cursor_pos = api.nvim_win_get_cursor(0)
            require("utils.file_info").show_file_info(entry.path, {
              row = current_cursor_pos[1],
              col = current_cursor_pos[2],
            })
          end,
        },
        confirm = {
          ---@param view FylerConfirmView
          ---@param cb fun(confirmed: boolean)
          ["N"] = function(view, cb)
            cb(false)
            vim.notify("Cancelled", vim.log.levels.INFO)
            view:close()
          end,
        },
      },
      icon_provider = "nvim-web-devicons",
      views = {
        explorer = {
          close_on_select = false,
          track_current_buffer = false,
          win = {
            kind = "split_left_most",
            kind_presets = {
              split_left_most = {
                width = "0.2rel",
              },
            },
            win_opts = {
              winfixwidth = true,
              winfixheight = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("fyler").setup(opts)
    end,
  },
}
