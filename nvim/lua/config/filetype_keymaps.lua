--- Filetype-specific keymap helper
---
--- 为指定文件类型批量注册 buffer-local keymap 的模板函数。
--- 内部自动创建 FileType autocmd，避免污染全局 keymap。
---
--- Usage:
---
---   local ft = require("config.filetype_keymaps")
---
---   -- 为 python 文件设置 keymap
---   ft("python", {
---     { "n", "<leader>rr", "<cmd>TermExec cmd='python %'<CR>", desc = "Run Python file" },
---     { "n", "<leader>rt", "<cmd>TermExec cmd='pytest %'<CR>", desc = "Run pytest" },
---   })
---
---   -- 为 markdown 文件设置 keymap
---   ft("markdown", {
---     { "n", "<leader>mp", "<cmd>MarkdownPreview<CR>", desc = "Preview Markdown" },
---   })
---
---   -- 也支持表语法，一次设置多个文件类型
---   ft({ "python", "lua", "vim" }, {
---     { "n", "<leader>c", "y$", desc = "Yank to end of line" },
---   })
---
--- @param filetypes string|string[]  文件类型，如 "python" 或 { "python", "lua" }
--- @param keymaps  table[]           keymap 定义列表，每项为 { modes, lhs, rhs, opts? }
local function filetype_keymaps(filetypes, keymaps)
  filetypes = type(filetypes) == "string" and { filetypes } or filetypes

  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    group = vim.api.nvim_create_augroup("filetype_keymaps_" .. table.concat(filetypes, "_"), { clear = true }),
    callback = function(env)
      for _, km in ipairs(keymaps) do
        local modes = km[1]
        local lhs = km[2]
        local rhs = km[3]
        local opts = vim.tbl_extend("force", km[4] or {}, {
          buffer = env.buf,
        })
        vim.keymap.set(modes, lhs, rhs, opts)
      end
    end,
  })
end

return filetype_keymaps
