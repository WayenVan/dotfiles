---@module "neominimap.config.meta"
return {
  "Isrothy/neominimap.nvim",
  version = "v3.*.*",
  enabled = true,
  lazy = false, -- NOTE: NO NEED to Lazy load
  -- Optional
  keys = {
    -- Global Minimap Controls
    { "<leader>m", "<Nop>", desc = "+MiniMap" },
    { "<leader>mm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
    { "<leader>mo", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
    { "<leader>mc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
    { "<leader>mr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

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
    { "<leader>mF", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
    { "<leader>mu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
    { "<leader>mf", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36 -- Set a large value

    --- Put your configuration here
    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      -- layout = "split",
      exclude_filetypes = {
        "help",
        "bigfile", -- For Snacks.nvim
        "gitcommit",
      },
      minimap_width = 1,
      auto_enable = true,
      float = {
        z_index = 3,
        window_border = "none",
      },
      mark = {
        enabled = true,
      },
      click = {
        enabled = true,
      },
      win_filter = function(winid)
        return winid == vim.api.nvim_get_current_win()
      end,
    }

    vim.api.nvim_create_autocmd("WinEnter", {
      group = vim.api.nvim_create_augroup("minimap", { clear = true }),
      pattern = "*",
      callback = function()
        require("neominimap").tabRefresh({}, {})
      end,
    })
  end,
}
