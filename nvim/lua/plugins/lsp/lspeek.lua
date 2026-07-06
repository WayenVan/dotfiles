return {
  {
    "WayenVan/lspeek.nvim",
    opts = {
      window = {
        width = 180,
        height = 50,
        border = "single", -- double | rounded | solid | shadow
        -- Window-local options applied to the preview window.
        -- Each key-value pair is set via vim.api.nvim_set_option_value.
        win_opts = {
          -- Examples:
          number = true,
          relativenumber = true,
          cursorline = true,
        },
      },

      -- Limits the number of stacked preview windows.
      stack_limit = 5,

      -- LSP can return multiple definitions
      -- (e.g., overloaded functions or multiple clients).
      -- false = open vim.ui.select to pick one (pairs well with a picker plugin).
      -- true  = skip the picker and preview the first result.
      select_first = false,

      -- Keymaps available inside the preview window.
      keymaps = {
        close = "q",
        split = "<localleader>s",
        vsplit = "<localleader>v",
        enter = "<CR>",
        tab = "<localleader>t",
        prev = "[",
        next = "]",
      },
    },

    -- Keymaps call the Lua API. Alternatively, use user commands:
    -- :LSPeekDef      -> Peek Definition
    -- :LSPeekTypeDef  -> Peek Type Definition
    keys = {
      -- {
      --   "gD",
      --   function()
      --     require("lspeek").peek_definition()
      --   end,
      --   desc = "Peek Definition (lspeek)",
      -- },
      -- {
      --   "gT",
      --   function()
      --     require("lspeek").peek_type_definition()
      --   end,
      --   desc = "Peek Type Definition (lspeek)",
      -- },
    },
  },
}
