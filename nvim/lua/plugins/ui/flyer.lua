return {
  {
    -- "A7Lavinraj/fyler.nvim",
    dir = "~/Desktop/forked/fyler.nvim",
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
          ["Y"] = "copy_selector",
        },
      },
      commands = {
        explorer = {
          ---@param view FylerExplorerView
          ---@return fun()
          ["copy_selector"] = function(view)
            local algos = require("fyler.views.explorer.algos")
            local store = require("fyler.views.explorer.store")
            local api = vim.api
            return function()
              local itemid = algos.match_itemid(api.nvim_get_current_line())
              if not itemid then
                return
              end
              local entry = store.get_entry(itemid)
              -- vim.notify(vim.inspect(entry))
              require("utils.yank_path").yank_path_picker(entry.path)
            end
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
