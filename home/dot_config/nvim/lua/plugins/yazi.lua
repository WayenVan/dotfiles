return {
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    cmd = "Yazi",
    init = function()
      -- Let Yazi handle directory buffers instead of netrw.
      vim.g.loaded_netrwPlugin = 1
      require("utils.yazi_session").setup()
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    -- Keep <leader>- for Oil; adjust these entry points to taste.
    keys = {
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi (cwd)",
      },
      { "<leader>O", "", desc = "+ Open in Yazi" },
      {
        "<leader>Of",
        "<cmd>Yazi<cr>",
        desc = "Yazi (current file)",
      },
      {
        "<leader>Od",
        function()
          require("yazi").yazi(nil, vim.fn.stdpath("data"))
        end,
        desc = "Yazi (std data)",
      },
      {
        "<leader>Oc",
        function()
          require("yazi").yazi(nil, vim.fn.stdpath("cache"))
        end,
        desc = "Yazi (cache)",
      },
      {
        "<leader>Os",
        function()
          require("yazi").yazi(nil, vim.fn.stdpath("state"))
        end,
        desc = "Yazi (state)",
      },
      {
        "<leader>Or",
        function()
          require("yazi").yazi(nil, LazyVim.root())
        end,
        desc = "Yazi (root)",
      },
      {
        "<leader>e",
        function()
          require("utils.yazi_session").open()
        end,
        desc = "Yazi (restore session)",
      },
      {
        "<leader>fy",
        "<cmd>Yazi<cr>",
        mode = { "n", "v" },
        desc = "Yazi (current file)",
      },
      {
        "<leader>fY",
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi (cwd)",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- Handle both startup directory arguments and :edit <directory>.
      open_for_directories = true,
      change_neovim_cwd_on_close = false,
      -- Avoid lighting up editor buffers behind the Yazi window.
      highlight_hovered_buffers_in_same_directory = false,
      open_multiple_tabs = false,

      forwarded_dds_events = { "nvim-session" },
      hooks = {
        on_yazi_ready = function(buffer, config, api)
          require("utils.yazi_session").ready(buffer, config, api)
        end,
      },

      -- Floating window appearance.
      floating_window_scaling_factor = 0.9,
      yazi_floating_window_border = "single",
      yazi_floating_window_winblend = 0,

      -- These mappings are active inside the Yazi terminal window.
      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-x>",
        open_file_in_tab = "<c-t>",
        send_to_quickfix_list = "<c-q>",
        -- Let Ctrl+o and Tab/Ctrl+i reach Yazi for directory-history navigation.
        open_and_pick_window = false,
        cycle_open_buffers = false,
      },
    },
    -- lazy.nvim calls require("yazi").setup(opts) automatically.
  },
}
