local M = {}

---@param filepath string file path
---@param opts snacks.win.Config
function M.show_file_info(filepath, opts)
  opts = opts or {}

  vim.schedule(function()
    local stat = vim.loop.fs_stat(filepath)
    if not stat then
      vim.notify("Could not get file info", vim.log.levels.ERROR)
      return
    end
    local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "none"
    local size_kb = string.format("%.2f KB", stat.size / 1024)
    local mtime = os.date("%Y-%m-%d %H:%M:%S", stat.mtime.sec)
    local filename = vim.fn.fnamemodify(filepath, ":t")
    -- local filepath = vim.fn.fnamemodify(filepath, ":p")
    local filepath_cwd = vim.fn.fnamemodify(filepath, ":.")
    local lines = {
      " ",
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

    local win_opts = {
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
      height = #lines + 1,
      backdrop = false,
    }
    win_opts = vim.tbl_deep_extend("force", win_opts, opts)

    local win = Snacks.win(win_opts)
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

    win:set_title("File Info (press <CR> to copy)")
    win:show()

    -- Add highlighting for labels
    local ns = vim.api.nvim_create_namespace("file_info_hl")
    local labels = { "Name", "Path", "Path (CWD)", "Type", "Size", "Modified" }
    for i, label in ipairs(labels) do
      local line = i
      local start_col = 1 -- Start after leading space
      local end_col = start_col + #label
      vim.api.nvim_buf_set_extmark(win.buf, ns, line, start_col, {
        end_col = end_col,
        hl_group = "Debug",
      })
    end
  end)
end

return M
