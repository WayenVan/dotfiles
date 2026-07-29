return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      {
        "<leader>_",
        function()
          -- require("oil").open_float()
          require("oil").toggle_float()
        end,
        desc = "Open parent directory",
      },
      {
        "<leader>-",
        function() end,
        desc = "Open recent",
      },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      float = {
        border = "single",
        max_width = 0.7,
        max_height = 0.9,
        zindex = 10000,
        -- 类似 Yazi：文件列表在左，预览在右
        preview_split = "right",
      },
      -- stylelua: ignore
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["L"] = "actions.select",
        ["<localleader>v"] = "actions.select_vsplit",
        ["<localleader>s"] = "actions.select_split",
        ["<C-l>"] = false,
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["H"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
        ["<c-o>"] = {
          callback = function()
            local entry = require("oil").get_cursor_entry()
            local dir = require("oil").get_current_dir()

            if not entry or not dir then
              return
            end

            local abs_path = dir .. "/" .. entry.name

            local default_win_id = vim.api.nvim_get_current_win()

            local win_id = Snacks.picker.util.pick_win({ main = default_win_id })
            if not win_id then
              return
            end

            vim.fn.win_execute(win_id, "edit " .. vim.fn.fnameescape(abs_path))
            vim.api.nvim_set_current_win(win_id)
          end,
          desc = "Open parent directory in a floating window",
        },
        ["<localleader>o"] = {
          callback = function()
            local entry = require("oil").get_cursor_entry()
            local dir = require("oil").get_current_dir()

            if not entry or not dir then
              return
            end

            local abs_path = dir .. "/" .. entry.name

            vim.ui.open(abs_path)
          end,
          desc = "Open file in system",
        },
        ["Y"] = {
          callback = function()
            local entry = require("oil").get_cursor_entry()
            local dir = require("oil").get_current_dir()

            if not entry or not dir then
              return
            end

            local abs_path = dir .. "/" .. entry.name

            require("utils.yank_path").yank_path_picker(abs_path)
          end,
          desc = "Open file in system",
        },
      },
    },
    -- Optional dependencies
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function(_, opts)
      require("oil").setup(opts)
      local last_oil_dir = nil

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function(args)
          vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
            buffer = args.buf,
            callback = function()
              local dir = require("oil").get_current_dir(args.buf)
              if dir then
                last_oil_dir = dir
              end
            end,
          })
        end,
      })

      local function reopen_last_oil()
        local oil = require("oil")

        if last_oil_dir then
          oil.open_float(last_oil_dir)
        else
          oil.open_float()
        end
      end

      vim.keymap.set("n", "<leader>-", reopen_last_oil, { desc = "Reopen last oil directory" })
    end,
  },
}
