return {
  {
    name = "Copy Filename",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local full_path = vim.api.nvim_buf_get_name(old_buf)
      local filename = vim.fn.fnamemodify(full_path, ":t")
      vim.fn.setreg('"', filename)
      vim.notify("Copied " .. filename .. " to unamed", "info")
    end,
    rtxt = "Y",
  },
  {
    name = "Copy Relative Path",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local full_path = vim.api.nvim_buf_get_name(old_buf)
      local relative_path = vim.fn.fnamemodify(full_path, ":.")
      vim.fn.setreg('"', relative_path)
      vim.notify("Copied " .. relative_path .. " to unamed", "info")
    end,
    rtxt = "gy",
  },
  {
    name = "Copy Relative Path",
    cmd = function()
      local old_buf = require("menu.state").old_data.buf
      local full_path = vim.api.nvim_buf_get_name(old_buf)
      local absolute_path = vim.fn.fnamemodify(full_path, ":.")
      vim.fn.setreg('"', absolute_path)
      vim.notify("Copied " .. absolute_path .. " to unamed", "info")
    end,
    rtxt = "gY",
  },

  { name = "separator" },

  {
    name = "  Lsp Actions",
    hl = "Define",
    items = "lsp",
  },

  { name = "separator" },

  {
    name = "Edit Config",
    cmd = function()
      vim.cmd("tabnew")
      local conf = vim.fn.stdpath("config")
      vim.cmd("tcd " .. conf .. " | e init.lua")
    end,
    rtxt = "ed",
  },

  {
    name = "Copy Content",
    cmd = "%y+",
    rtxt = "<C-c>",
  },

  {
    name = "Delete Content",
    cmd = "%d",
    rtxt = "dc",
  },

  { name = "separator" },

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
    rtxt = "gt",
  },
}
