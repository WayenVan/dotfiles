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
          vim.schedule(function()
            local inst = require("fyler.finder").instance_get_or_nil()
            if not inst then
              return
            end
            inst:follow({ target_path = file })
          end)
        end,
        desc = "track current buffer in Fyler",
      },
    },
    opts = {
      -- Auto focus current file
      follow_current_file = false,
      kind = "split_left_most",
      win_opts = {
        number = true,
        relativenumber = true,
      },
      kind_presets = {
        split_left_most = {
          width = "15%",
        },
      },
      -- hooks = {
      --   on_rename = function(src_path, destination_path)
      --     Snacks.rename.on_rename_file(src_path, destination_path)
      --     vim.notify("Lsp renamed file: " .. src_path .. " -> " .. destination_path, vim.log.levels.INFO)
      --   end,
      -- },
      mappings = {

        n = {
          ["<localleader>v"] = {
            action = "select",
            args = { vsplit = true },
          },
          ["<localleader>s"] = {
            action = "select",
            args = { split = true },
          },

          ["Y"] = {
            action = function(self)
              local entry = require("fyler.finder").parse_cursor_line(self)
              if not entry then
                return
              end
              require("utils.yank_path").yank_path_picker(entry.path)
            end,
          },
          ["K"] = {
            action = function(self)
              local pos = vim.fn.screenpos(0, vim.fn.line("."), vim.fn.col("."))
              local entry = require("fyler.finder").parse_cursor_line(self)
              if not entry then
                return
              end
              require("utils.file_info").show_file_info(entry.path, {
                row = pos.row + 1,
                col = pos.col + 1,
              })
            end,
          },
          ["<c-o>"] = {
            action = function(self)
              local entry = require("fyler.finder").parse_cursor_line(self)
              if not entry then
                return
              end
              local default_win_id = vim.api.nvim_get_current_win()
              local win_id = Snacks.picker.util.pick_win({ main = default_win_id })
              if not win_id then
                return
              end
              vim.fn.win_execute(win_id, "edit " .. vim.fn.fnameescape(entry.path))
              vim.api.nvim_set_current_win(win_id)
            end,
          },
          ["<C-s>"] = {
            disabled = true,
          },
          ["<localleader>o"] = {
            action = function(self)
              local entry = require("fyler.finder").parse_cursor_line(self)
              if not entry then
                return
              end
              vim.ui.open(entry.path)
            end,
          },
          ["<leader>-"] = {
            action = function(self)
              local entry = require("fyler.finder").parse_cursor_line(self)
              if not entry then
                return
              end
              require("oil").open_float(vim.fs.dirname(entry.path))
              -- require("utils.oil").focus_file_in_oil(entry.path)
            end,
          },
        },
      },
      integrations = {
        icon = "nvim_web_devicons",
      },
      ui = {
        indent_guides = true,
      },
    },
    config = function(_, opts)
      require("fyler").setup(opts)
      local config = require("fyler.config")
      -- vim.notify(vim.inspect(config), vim.log.levels.INFO)
      -- vim.notify(vim.inspect(config.values.views.finder.follow_current_file), vim.log.levels.INFO)
      --
      -- local group = vim.api.nvim_create_augroup("FylerConfig", { clear = true })
      -- vim.api.nvim_create_autocmd({ "Filetype" }, {
      --   pattern = { "fyler" },
      --   group = group,
      --   callback = function(ev)
      --     vim.keymap.set("n", "<esc>", function()
      --       require("fff.picker_ui").close()
      --     end, { buffer = ev.buf, nowait = true })
      --   end,
      -- })
    end,
  },
}
