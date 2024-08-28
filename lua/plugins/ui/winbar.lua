return {
  {
    "fgheng/winbar.nvim",
    event = "VeryLazy",
    -- enabled = false,
    opts = {
      -- manual setup
      enabled = false,
    },

    config = function(_, opts)
      local wb = require("winbar")
      wb.setup(opts)
      vim.api.nvim_create_autocmd(
        { "DirChanged", "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" },
        {
          callback = function()
            local buf_type = vim.bo.buftype
            if buf_type == "" then
              local winbar = require("winbar.winbar")
              winbar.show_winbar()
            end
          end,
        }
      )
    end,
  },
}
