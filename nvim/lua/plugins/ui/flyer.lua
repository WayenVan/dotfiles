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
            win_opts = {
              number = true,
              relativenumber = true,
            },
          },
          follow_current_file = false,
          mappings = {
            ["Y"] = function(self)
              local entry = self:cursor_node_entry()
              if not entry then
                return
              end
              require("utils.yank_path").yank_path_picker(entry.path)
            end,
            ["K"] = function(self)
              local entry = self:cursor_node_entry()
              if not entry then
                return
              end

              local current_cursor_pos = api.nvim_win_get_cursor(0)
              require("utils.file_info").show_file_info(entry.path, {
                row = current_cursor_pos[1],
                col = current_cursor_pos[2],
              })
            end,
            ["L"] = function(self)
              local entry = self:cursor_node_entry()
              if not entry then
                return
              end
              local win_id = require("utils.window_pick").pick()
              if not win_id then
                return
              end
              vim.fn.win_execute(win_id, "edit " .. vim.fn.fnameescape(entry.path))
              vim.api.nvim_set_current_win(win_id)
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
      local config = require("fyler.config")
      -- vim.notify(vim.inspect(config), vim.log.levels.INFO)
      -- vim.notify(vim.inspect(config.values.views.finder.follow_current_file), vim.log.levels.INFO)
      --
      local group = vim.api.nvim_create_augroup("FylerConfig", { clear = true })
      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = { "fyler" },
        group = group,
        callback = function(ev)
          vim.keymap.set("n", "<esc>", function()
            require("fff.picker_ui").close()
          end, { buffer = ev.buf, nowait = true })
        end,
      })
    end,
  },
}
