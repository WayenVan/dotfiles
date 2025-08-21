return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
      local devicons = require("nvim-web-devicons")
      local helpers = require("incline.helpers")
      require("incline").setup({
        hide = {
          cursorline = true, -- Disable hiding cursorline
          focused_win = false, -- Disable hiding in focused window
        },
        window = {
          padding = 0,
          margin = { horizontal = 0 },
          -- overlap = {
          --   borders = false,
          --   winbar = false,
          --
          --   tabline = true,
          -- },
        },
        render = function(props)
          local mark_fg = vim.api.nvim_get_hl(0, { name = "WarningMsg" }).fg
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          -- local ft_icon, ft_color = devicons.get_icon_color(filename)
          --
          local modified = vim.bo[props.buf].modified

          return {
            -- ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
            {
              filename,
              gui = modified and "bold,italic" or "bold",
            },
            modified and { "*", guifg = string.format("#%06x", mark_fg) } or " ",

            -- guibg = vim.api.nvim_get_hl(0, { name = "PmenuThumb" }).bg,
            --
          }
        end,
      })
    end,
  },
}
