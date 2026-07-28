M = {}

function M.open_oil_float_at_file(filepath)
  local oil = require("oil")

  filepath = vim.fs.normalize(vim.fn.fnamemodify(vim.fn.expand(filepath), ":p"))

  local stat = vim.uv.fs_stat(filepath)
  if not stat or stat.type ~= "file" then
    vim.notify("File does not exist: " .. filepath, vim.log.levels.ERROR)
    return
  end

  local directory = vim.fs.dirname(filepath)
  local filename = vim.fs.basename(filepath)

  local function focus_file(bufnr, winid)
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return false
    end

    if not vim.api.nvim_win_is_valid(winid) then
      return false
    end

    local line_count = vim.api.nvim_buf_line_count(bufnr)

    for line = 1, line_count do
      local entry = oil.get_entry_on_line(bufnr, line)

      if entry and entry.name == filename then
        vim.api.nvim_win_set_cursor(winid, { line, 0 })

        -- 将目标文件放在窗口中央
        vim.api.nvim_win_call(winid, function()
          vim.cmd("normal! zz")
        end)

        return true
      end
    end

    return false
  end

  oil.open_float(directory, nil, function()
    local bufnr = vim.api.nvim_get_current_buf()
    local winid = vim.api.nvim_get_current_win()

    vim.schedule(function()
      if focus_file(bufnr, winid) then
        return
      end

      -- 目标是隐藏文件时，尝试显示隐藏文件后再次定位
      if filename:sub(1, 1) == "." then
        oil.toggle_hidden()

        vim.schedule(function()
          focus_file(bufnr, winid)
        end)
      end
    end)
  end)
end

return M
