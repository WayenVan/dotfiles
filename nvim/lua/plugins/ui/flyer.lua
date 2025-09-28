return {
  {

    "A7Lavinraj/fyler.nvim",
    -- dir = "~/Desktop/forked/fyler.nvim",
    -- branch = "feature/multi_tabs_support",
    -- dependencies = { "echasnovski/mini.icons" },
    enabled = true,
    branch = "stable",
    dependencies = {
      "DaikyXendo/nvim-material-icon",
      -- "nvim-tree/nvim-web-devicons",
    },
    -- branch = "stable",
    keys = {
      {
        "<leader>r",
        function()
          require("fyler").open()
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
        ["Y"] = function()
          local explorer = require("fyler.explorer")
          local current = explorer.current()
          if not current or not current.file_tree then
            return
          end
          api = vim.api
          local e_util = require("fyler.explorer.util")

          local ref_id = e_util.parse_ref_id(api.nvim_get_current_line())
          if not ref_id then
            return
          end

          local entry = current.file_tree:node_entry(ref_id)
          if not entry then
            return
          end
          -- vim.notify(vim.inspect(entry))
          current:close()
          require("utils.yank_path").yank_path_picker(entry.path)
        end,
        ["K"] = function()
          local explorer = require("fyler.explorer")
          local current = explorer.current()
          if not current or not current.file_tree then
            return
          end
          api = vim.api
          local e_util = require("fyler.explorer.util")

          local ref_id = e_util.parse_ref_id(api.nvim_get_current_line())
          if not ref_id then
            return
          end

          local entry = current.file_tree:node_entry(ref_id)
          if not entry then
            return
          end

          local current_cursor_pos = api.nvim_win_get_cursor(0)
          require("utils.file_info").show_file_info(entry.path, {
            row = current_cursor_pos[1],
            col = current_cursor_pos[2],
          })
        end,
      },
      --   confirm = {
      --     ---@param view FylerConfirmView
      --     ---@param cb fun(confirmed: boolean)
      --     ["N"] = function(view, cb)
      --       cb(false)
      --       vim.notify("Cancelled", vim.log.levels.INFO)
      --       view:close()
      --     end,
      --   },
      -- },
      icon_provider = "nvim_web_devicons",
      track_current_buffer = false,
      -- views = {
      --   explorer = {
      close_on_select = true,
      --     track_current_buffer = false,
      win = {
        kind = "float",
        kind_presets = {
          split_left_most = {
            width = "0.2rel",
          },
        },
        --       win_opts = {
        --         winfixwidth = true,
        --         winfixheight = true,
        --       },
        --     },
        --   },
      },
    },
    config = function(_, opts)
      require("fyler").setup(opts)
    end,
  },
}
