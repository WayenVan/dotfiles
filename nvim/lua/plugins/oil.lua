return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      {
        "<leader>-",
        function()
          -- require("oil").open_float()
          require("oil").open()
        end,
        desc = "Open parent directory",
      },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false,
      float = {
        border = "single",
        max_with = 0.8,
        max_height = 0.9,
        zindex = 10000,
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
      },
    },
    -- Optional dependencies
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function(_, opts)
      require("oil").setup(opts)
      -- create an autocmd to listen for the OilActionsPost event and call Snacks.rename.on_rename_file when a file is moved
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "OilActionsPost",
      --   callback = function(event)
      --     if event.data.actions[1].type == "move" then
      --       Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
      --       -- vim.notify(
      --       --   "Lsp renamed file: " .. event.data.actions[1].src_url .. " -> " .. event.data.actions[1].dest_url,
      --       --   vim.log.levels.INFO
      --       -- )
      --     end
      -- end,
      -- })
    end,
  },
}
