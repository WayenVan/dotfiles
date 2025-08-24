return {
  {
    name = "Show File Info",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local old_win = require("menu.state").old_data.win

      local bufname = vim.api.nvim_buf_get_name(old_buf)
      if bufname == "" then
        vim.notify("No file loaded in buffer", vim.log.levels.WARN)
        return
      end
      -- Find the window that contains the buffer
      local winid = old_win
      -- If the buffer is not visible in any window, return nil

      -- 2. Window top-left in screen space
      local win_row, win_col = unpack(vim.api.nvim_win_get_position(winid))

      -- 3 & 4. Cursor position within the screen
      local screen_line = vim.fn.winline()
      local screen_col = vim.fn.wincol()

      -- 5. Calculate global screen position
      local absolute_row = win_row + screen_line - 1
      local absolute_col = win_col + screen_col - 1

      require("utils.file_info").show_file_info(bufname, {
        row = absolute_row,
        col = absolute_col,
      })
    end,
    rtxt = "f",
  },
  { name = "separator" },
  {
    name = "Copy Picker",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local full_path = vim.api.nvim_buf_get_name(old_buf)
      require("utils.yank_path").yank_path_picker(full_path)
    end,
    rtxt = "Y",
  },
  {
    name = "Copy Relative Path",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local full_path = vim.api.nvim_buf_get_name(old_buf)
      require("utils.yank_path").yank_path(":.", full_path)
    end,
    rtxt = "gy",
  },
  {
    name = "Copy Absolute Path",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local full_path = vim.api.nvim_buf_get_name(old_buf)
      require("utils.yank_path").yank_path("", full_path)
    end,
    rtxt = "gY",
  },
  --
  { name = "separator" },
  --
  -- {
  --   name = "  Lsp Actions",
  --   hl = "Define",
  --   items = "lsp",
  -- },
  {
    name = "Peek definition",
    cmd = function()
      require("overlook.api").peek_definition()
    end,
    rtxt = "d",
  },
  {
    name = "Peek cursor",
    cmd = function()
      require("overlook.api").peek_cursor()
    end,
    rtxt = "c",
  },
  {
    name = "Restore all peek windows",
    cmd = function()
      require("overlook.api").restore_all_popups()
    end,
    rtxt = "r",
  },
  {
    name = "Restore peek window",
    cmd = function()
      require("overlook.api").restore_popup()
    end,
    rtxt = "R",
  },
  {
    name = "Close all peek windows",
    cmd = function()
      require("overlook.api").close_all()
    end,
    rtxt = "x",
  },

  { name = "separator" },
  {
    name = "Show Formatter Info",
    cmd = function()
      LazyVim.format.info(vim.api.nvim_get_current_buf())
    end,
    rtxt = "if",
  },
  {
    name = "Show LSP Info",
    cmd = function()
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        vim.notify("No LSP clients attached.", vim.log.levels.WARN)
      else
        for _, client in pairs(clients) do
          vim.notify(vim.inspect(client.server_capabilities), client.name)
        end
      end
    end,
    rtxt = "il",
  },

  { name = "separator" },

  {
    name = "Color Shades",
    cmd = function()
      vim.cmd("Shades")
    end,
    rtxt = "Ms",
  },
  {
    name = "Color Huefy",
    cmd = function()
      vim.cmd("Huefy")
    end,
    rtxt = "Mh",
  },

  { name = "separator" },

  -- {
  --   name = "Edit Config",
  --   cmd = function()
  --     vim.cmd("tabnew")
  --     local conf = vim.fn.stdpath("config")
  --     vim.cmd("tcd " .. conf .. " | e init.lua")
  --   end,
  --   rtxt = "ed",
  -- },
  --
  -- {
  --   name = "Copy Content",
  --   cmd = "%y+",
  --   rtxt = "<C-c>",
  -- },
  --
  -- {
  --   name = "Delete Content",
  --   cmd = "%d",
  --   rtxt = "dc",
  -- },
  --
  -- { name = "separator" },

  {
    name = "  Open in terminal",
    hl = "Debug",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local old_bufname = vim.api.nvim_buf_get_name(old_buf)
      local old_buf_dir = vim.fn.fnamemodify(old_bufname, ":h")

      -- local cmd = "cd " .. old_buf_dir
      local t = require("toggleterm.terminal")
      t.Terminal
        :new({
          dir = old_buf_dir,
        })
        :toggle()
    end,
    rtxt = "t",
  },
}
