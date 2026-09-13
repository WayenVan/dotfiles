local M = {}

function M.open()
  local root = vim.fn.getcwd()
  local path = vim.fs.joinpath(vim.fn.fnamemodify(root, ":p"), "TODO.md")
  local stat = vim.uv.fs_stat(path)

  if not stat then
    local width = math.max(20, math.min(56, vim.o.columns - 6))
    local button_padding = math.floor((width - 12) / 2)
    local buttons = string.rep(" ", button_padding) .. "[y]es / [n]o"
    local selected = true
    local ns = vim.api.nvim_create_namespace("ProjectTodoConfirm")
    local info = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo", link = false })
    vim.api.nvim_set_hl(0, "ProjectTodoPath", { fg = info.fg or "#7dcfff", bold = true })

    local function highlight(win)
      vim.api.nvim_buf_clear_namespace(win.buf, ns, 0, -1)
      vim.api.nvim_buf_set_extmark(win.buf, ns, 2, 2, {
        end_row = 2,
        end_col = 2 + #path,
        hl_group = "ProjectTodoPath",
      })
      vim.api.nvim_buf_set_extmark(win.buf, ns, 0, 2, {
        end_row = 0,
        end_col = #"  Create TODO.md here?",
        hl_group = "Comment",
      })
      local start = button_padding + (selected and 0 or 8)
      vim.api.nvim_buf_set_extmark(win.buf, ns, 4, start, {
        end_row = 4,
        end_col = start + (selected and 5 or 4),
        hl_group = "PmenuSel",
      })
    end

    local function create(win)
      win:close()
      -- Exclusive creation avoids overwriting a file created while confirming.
      local fd, err = vim.uv.fs_open(path, "wx", 420)
      if not fd then
        vim.notify("Cannot create " .. path .. "\n" .. tostring(err), vim.log.levels.ERROR)
        return
      end
      vim.uv.fs_close(fd)
      vim.cmd.edit(vim.fn.fnameescape(path))
    end

    local function toggle(win)
      selected = not selected
      highlight(win)
    end

    require("snacks").win({
      title = " TODO ",
      text = { "  Create TODO.md here?", "", "  " .. path, "", buttons },
      width = width,
      height = math.min(vim.o.lines - 4, 4 + math.ceil((vim.fn.strdisplaywidth(path) + 2) / width)),
      border = "rounded",
      backdrop = 60,
      enter = true,
      bo = { modifiable = false },
      wo = { wrap = true, linebreak = false, cursorline = false },
      on_win = function(win)
        highlight(win)
        vim.api.nvim_win_set_cursor(win.win, { 5, button_padding })
      end,
      keys = {
        y = create,
        n = "close",
        ["<Esc>"] = "close",
        ["<Tab>"] = toggle,
        ["<S-Tab>"] = toggle,
        ["<Left>"] = toggle,
        ["<Right>"] = toggle,
        ["<CR>"] = function(win)
          if selected then
            create(win)
          else
            win:close()
          end
        end,
      },
    })
    return
  elseif stat.type ~= "file" then
    vim.notify("Not a regular file: " .. path, vim.log.levels.ERROR)
    return
  end

  vim.cmd.edit(vim.fn.fnameescape(path))
end

return M
