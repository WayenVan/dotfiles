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
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          --
          local modified = vim.bo[props.buf].modified

          return {
            ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
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

      --  改良版的 incline 高亮修复
      local function fix_incline_high_light()
        local all_highlights = vim.api.nvim_get_hl(0, {})
        for name, hl_def in pairs(all_highlights) do
          local fg = name:match("incline__guifg_([0-9a-fA-F]+)") -- 提取十六进制颜色代码
          if fg then
            vim.api.nvim_set_hl(0, name, { fg = "#" .. fg })
          end
          local bg = name:match("incline__guibg_([0-9a-fA-F]+)") -- 提取十六进制颜色代码
          if bg then
            vim.api.nvim_set_hl(0, name, { bg = "#" .. bg })
          end
          local bold = name:match("^incline__gui_bold$")

          if bold then
            vim.api.nvim_set_hl(0, name, { bold = true })
          end
          local bi = name:match("^incline__gui_bolditalic$")
          if bi then
            vim.api.nvim_set_hl(0, name, { bold = true, italic = true })
          end
        end
      end

      -- 3. 创建一个 autocommand 组
      local augroup = vim.api.nvim_create_augroup("InclineBgSwitch", { clear = true })
      -- 4. 监听 OptionSet 事件，仅针对 'background' 选项
      vim.api.nvim_create_autocmd("OptionSet", {
        group = augroup,
        pattern = "background",
        callback = function()
          -- 每次背景改变时重新保存并恢复高亮
          -- fix_incline_high_light()
          require("lazy.core.loader").reload("incline.nvim")
        end,
      })
    end,
  },
}
