return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    opts = {
      at_edge = "warp",
      multiplexer_integration = false,
    },
    keys = {
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize Down",
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize Up",
      },
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize Left",
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize Right",
      },
      {
        "<C-\\>",
        function()
          require("smart-splits").move_cursor_previous()
        end,
        desc = "Move Cursor Previous",
      },
      -- {"<C-w>L", function() require("smart-splits").swap_buf_right() end, desc = "Move Buffer Right"},
      -- {"<C-w>H", function() require("smart-splits").swap_buf_left() end, desc = "Move Buffer Left"},
      -- {"<C-w>J", function() require("smart-splits").swap_buf_down() end, desc = "Move Buffer Down"},
      -- {"<C-w>K", function() require("smart-splits").swap_buf_up() end, desc = "Move Buffer Up"},
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "move cursor left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "move cursor down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "move cursor up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "move cursor right",
      },
    },
    -- {"<leader><leader>h", function() require("smart-splits").swap_buf_left() end, desc = "Swap Buffer Left"},
    -- {"<leader><leader>j", function() require("smart-splits").swap_buf_down() end, desc = "Swap Buffer Down"},
    -- {"<leader><leader>k", function() require("smart-splits").swap_buf_up() end, desc = "Swap Buffer Up"},
    -- {"<leader><leader>l", function() require("smart-splits").swap_buf_right() end, desc = "Swap Buffer Right"},
  },
}
