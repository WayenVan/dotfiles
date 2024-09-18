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
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (current file)",
      },
      { "<leader>O", "", desc = "+ Open in mini.files" },
      {
        "<leader>Od",
        function()
          local path = require("plenary.path"):new(vim.fn.stdpath("data")):absolute()
          require("mini.files").open(path, true, {})
        end,
        desc = "Open mini.files (std data)",
      },
      {
        "<leader>Or",
        function()
          -- require("mini.files").open(LazyVim.root(), true)
          require("mini.files").open(MiniFiles.get_latest_path())
        end,
        desc = "Open mini.files (Recent)",
      },
      {
        "<leader>Of",
        function()
          require("mini.files").open(LazyVim.root(), true)
        end,
        desc = "Open mini.files (root)",
      },
    },
    opts = {
      mappings = {
        go_in_plus = "<CR>",
        go_in = "L",
        go_out = "H",
        go_out_plus = "<BS>",
        reset = "<localleader><localleader>",
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
      local yank_filename = function()
        local entry = require("mini.files").get_fs_entry()
        if entry == nil then
          return
        end
        local modify = vim.fn.fnamemodify
        local filename = modify(entry.path, ":t")
        vim.fn.setreg('"', filename)
        require("noice").notify("Copied " .. filename .. " to unamed", "info")
      end

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
          vim.keymap.set(
            "n",
            "Y",
            yank_filename,
            { buffer = args.data.buf_id, desc = "yank name of current entry" }
          )
          -- vim.keymap.set("n", "gi", show_file_info, { buffer = args.data.buf_id, desc = "show file info" })
        end,
      })
    end,
  },
}
