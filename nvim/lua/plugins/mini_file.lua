return {
  {
    "echasnovski/mini.files",

    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(nil, true)
        end,
        desc = "Open mini.files (cwd)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(LazyVim.root(), true)
        end,
        desc = "Open mini.files (root)",
      },
      {
        "<leader>fe",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (current file)",
      },
    },
    opts = {
      mappings = {
        go_in_plus = "<CR>",
      },
      options = {
        use_as_default_explorer = true,
      },
    },

    config = function(_, opts)
      require("mini.files").setup(opts)

      -- set up y to copy
      local yank_relative_path = function()
        local path = MiniFiles.get_fs_entry().path
        vim.fn.setreg('"', vim.fn.fnamemodify(path, ":."))
        require("noice").notify("Copied " .. path .. " to unamed", "info")
      end
      local yank_absolute = function()
        local entry = require("mini.files").get_fs_entry()
        if entry == nil then
          return
        end
        local modify = vim.fn.fnamemodify
        local filepath = entry.path
        vim.fn.setreg('"', filepath)
        require("noice").notify("Copied " .. filepath .. " to unamed", "info")
      end

      -- local function show_file_info()
      --   local filepath = require("mini.files").get_fs_entry().path
      --   local filesize = vim.fn.getfsize(filepath)
      --   local bufnr = vim.api.nvim_create_buf(false, true)
      --   vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "File Size: " .. filesize .. " bytes" })
      --   local width = 30
      --   local height = 1
      --   local row = vim.fn.line(".") + 1
      --   local col = vim.fn.col(".")
      --   vim.api.nvim_open_win(bufnr, true, {
      --     relative = "editor",
      --     width = width,
      --     height = height,
      --     row = row,
      --     col = col,
      --     style = "minimal",
      --     border = "single",
      --     focusable = false,
      --   })
      --   vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":q<CR>", { noremap = true, silent = true })
      -- end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set(
            "n",
            "gy",
            yank_relative_path,
            { buffer = args.data.buf_id, desc = "yank relative path of current entry" }
          )
          vim.keymap.set(
            "n",
            "gY",
            yank_absolute,
            { buffer = args.data.buf_id, desc = "yank absolute path of current entry" }
          )
          -- vim.keymap.set("n", "gi", show_file_info, { buffer = args.data.buf_id, desc = "show file info" })
        end,
      })
    end,
  },
}
