return {
  {

    "ramilito/winbar.nvim",
    event = "VimEnter", -- Alternatively, BufReadPre if we don't care about the empty file when starting with 'nvim'
    enabled = false,
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("winbar").setup({
        -- your configuration comes here, for example:
        icons = true,
        diagnostics = true,
        buf_modified = true,
        buf_modified_symbol = "M",
        -- or use an icon
        -- buf_modified_symbol = "●"
        dim_inactive = {
          enabled = false,
          highlight = "WinBarNC",
          icons = true, -- whether to dim the icons
          name = true, -- whether to dim the name
        },
      })
    end,
  },
}
