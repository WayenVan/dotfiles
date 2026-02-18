return {
  {
    "stevearc/oil.nvim",
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
        ["<C-v>"] = "actions.select_vsplit",
        -- ["<C-s>"] = "actions.select_split",
        ["<C-s>"] = false,
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["<"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
    },
    -- Optional dependencies
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}
