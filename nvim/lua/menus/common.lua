return {
  {
    name = "Show File Info",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local bufname = vim.api.nvim_buf_get_name(old_buf)
      if bufname == "" then
        vim.notify("No file loaded in buffer", vim.log.levels.WARN)
        return
      end

      local stat = vim.loop.fs_stat(bufname)
      if not stat then
        vim.notify("Could not get file info", vim.log.levels.ERROR)
        return
      end
      local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "none"
      local size_kb = string.format("%.2f KB", stat.size / 1024)
      local mtime = os.date("%Y-%m-%d %H:%M:%S", stat.mtime.sec)
      local filename = vim.fn.fnamemodify(bufname, ":t")
      local filepath = vim.fn.fnamemodify(bufname, ":p")
      local filepath_cwd = vim.fn.fnamemodify(bufname, ":.")

      local lines = {
        " Name      : " .. filename,
        " Path      : " .. filepath,
        " Path (CWD): " .. filepath_cwd,
        " Type      : " .. filetype,
        " Size      : " .. size_kb,
        " Modified  : " .. mtime,
      }

      local max_length = 0
      for _, line in ipairs(lines) do
        max_length = math.max(max_length, #line)
      end

      -- local filename = vim.fn.fnamemodify(full_path, ":t")
      local win = Snacks.win({
        text = lines,
        style = "float",
        border = "single",
        fixbuf = true,
        show = false,
        keys = {
          q = "close",
        },
        bo = {
          modifiable = false,
        },
        width = max_length + 2,
        height = #lines + 2,
      })
      win:set_title("File Info press <CR> to copy")
      win:show()

      -- Map <CR> to copy the line under cursor
      vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_get_current_line()
        -- Extract the value after the colon
        local content = line:match(":%s(.+)$")
        if content then
          vim.fn.setreg("+", content)
          vim.notify("Copied: " .. content)
        else
          vim.notify("Nothing to copy", vim.log.levels.WARN)
        end
      end, { buffer = win.buf, silent = true })
    end,
    rtxt = "s",
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
