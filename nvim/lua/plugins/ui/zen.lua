return {
  -- Lua
  {
    "folke/zen-mode.nvim",
    lazy = true,
    -- replaced by the snacks.zen
    enabled = true,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        -- width = 120,
        width = function()
          if vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "qf" then
            return vim.api.nvim_get_option_value("columns", { scope = "global" })
          else
            return 120
          end
        end,
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 3, -- turn off the statusline in zen mode
        },
      },
    },
    keys = function()
      require("which-key").add({
        { "<leader>z", group = "zen", icon = "🧘" },
      })
      return {
        { "<leader>zz", "<cmd>ZenMode<CR>", desc = "Zen mode" },
      }
    end,
  },
}
