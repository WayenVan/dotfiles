return {
  {

    "A7Lavinraj/fyler.nvim",
    -- dir = "~/Desktop/forked/fyler.nvim",
    -- branch = "feature/multi_tabs_support",
    -- dependencies = { "echasnovski/mini.icons" },
    enabled = true,
    -- branch = "stable",
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
          local file = vim.api.nvim_buf_get_name(0)
          vim.notify("Tracking current file in Fyler: " .. file, vim.log.levels.INFO)
          require("fyler").open()
          require("fyler").navigate(file)
        end,
        desc = "track current buffer in Fyler",
      },
    },
    opts = {
      -- Auto focus current file
      views = {
        finder = {
          win = {
            kind = "replace",
          },
          follow_current_file = false,
          mappings = {
            ["Y"] = function(self)
              local util = require("fyler.lib.util")

              local ref_id = util.parse_ref_id(vim.api.nvim_get_current_line())

              if not ref_id then
                return
              end

              local entry = self.files:node_entry(ref_id)
              if not entry then
                return
              end

              require("utils.yank_path").yank_path_picker(entry.path)
            end,
            ["K"] = function(self)
              local api = vim.api
              local util = require("fyler.lib.util")

              local ref_id = util.parse_ref_id(vim.api.nvim_get_current_line())

              if not ref_id then
                return
              end

              local entry = self.files:node_entry(ref_id)
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
        },
      },

      integrations = {
        icon = "nvim_web_devicons",
      },
    },
    config = function(_, opts)
      require("fyler").setup(opts)
    end,
  },
}
