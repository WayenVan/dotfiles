return {
  ---@module "neominimap.config.meta"
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    enabled = true,
    lazy = false, -- NOTE: NO NEED to Lazy load
    -- Optional. You can alse set your own keybindings
    keys = {
      -- Global Minimap Controls
      -- { "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
      -- { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
      -- { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
      -- { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },
      --
      -- -- Window-Specific Minimap Controls
      -- { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
      -- { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
      -- { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
      -- { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },
      --
      -- -- Tab-Specific Minimap Controls
      -- { "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
      -- { "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
      -- { "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
      -- { "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },
      --
      -- -- Buffer-Specific Minimap Controls
      -- { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
      -- { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      -- { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
      -- { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },
      --
      -- ---Focus Controls
      -- { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
      -- { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
      {
        "<leader>mm",
        function()
          local m = require("neominimap.api")
          m.toggle()
        end,
        desc = "Switch focus on minimap",
      },
      {
        "<leader>mf",
        function()
          local m = require("neominimap.api")
          m.focus.toggle()
        end,
        desc = "Switch focus on minimap",
      },
    },
    init = function()
      -- The following options are recommended when layout == "float"
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 5

      local minimap_autogroup = vim.api.nvim_create_augroup("minimap", { clear = true })
      vim.api.nvim_create_autocmd("WinEnter", {
        group = minimap_autogroup,
        pattern = "*",
        callback = function()
          require("neominimap.api").tab.refresh()
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = minimap_autogroup,
        pattern = "neominimap",
        callback = function(env)
          local function toggle()
            local m = require("neominimap.api")
            m.toggleFocus()
            m.toggle()
          end
          vim.keymap.set("n", "q", toggle, { noremap = true, silent = true, buffer = env.buf })
          vim.keymap.set("n", "<CR>", toggle, { noremap = true, silent = true, buffer = env.buf })
        end,
      })

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        layout = "split",
        sync_cursor = true,
        auto_enable = false,

        exclude_filetypes = {
          "help",
          "bigfile", -- For Snacks.nvim
          "snacks_picker_input", -- For Snacks.nvim
        },
        split = {
          minimap_width = 40,
        },
        float = {
          minimap_width = 40,
        },
        winopt = function(opt, winid)
          opt.number = true
          opt.relativenumber = true
        end,
        win_filter = function(winid)
          return winid == vim.api.nvim_get_current_win()
        end,

        click = {
          enabled = true,
          auto_switch_focus = true,
        },
        mark = {
          enabled = true,
        },
      }
    end,
  },
}
