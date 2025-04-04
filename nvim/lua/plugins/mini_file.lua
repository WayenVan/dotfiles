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
        reset = ".",
        synchronize = "<Tab>",
      },
      options = {
        use_as_default_explorer = true,
      },
    },

    config = function(_, opts)
      require("mini.files").setup(opts)

      local go_to_directory = function()
        local entry = MiniFiles.get_fs_entry()
        if entry == nil then
          return
        end
        local Path = require("plenary.path")
        local path = Path:new(entry.path)
        if path:is_dir() then
          vim.cmd("tcd " .. path:absolute())
        else
          vim.nodify("Not a directory")
        end
      end

      local open_in_system = function()
        local Path = require("plenary.path")
        local path = Path:new(MiniFiles.get_fs_entry().path)
        if path:is_dir() then
          path = path:absolute()
          -- is dir, oepn with system viewer
          local os_name = require("utils.os_name").get_os_name()

          if os_name == "Mac" then
            -- macOS: open Finder at the specified path
            vim.fn.jobstart({ "open", path }, { detach = true })
          elseif os_name == "Linux" then
            -- Linux: open file in default application
            vim.fn.jobstart({ "xdg-open", path }, { detach = true })
          elseif os_name == "Windows" then
            -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
            local p
            local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
            if lastSlashIndex then
              p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
            else
              p = path -- If no slash found, return original path
            end
            vim.notify(p)
            vim.cmd("silent !start " .. p)
          else
            vim.notify("Unsupported OS", "error", { title = "Error" })
          end
          return
        end
        -- no a dir, open with system application
        local uri = vim.uri_from_fname(path:absolute())
        require("lazy.util").open(uri, { system = true })
      end

      -- set up y to copy
      local yank_relative_path = function()
        local path = MiniFiles.get_fs_entry().path
        path = vim.fn.fnamemodify(path, ":.")
        vim.fn.setreg('"', path)
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

      local open_in_neotree = function()
        local entry = require("mini.files").get_fs_entry()
        if entry == nil then
          return
        end
        require("neo-tree.command").execute({
          action = "focus",
          toggle = false,
          position = "right",
          reveal_file = entry.path,
          dir = vim.fn.getcwd(),
        })
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
          vim.keymap.set("n", "Y", yank_filename, { buffer = args.data.buf_id, desc = "yank name of current entry" })
          vim.keymap.set(
            "n",
            "gr",
            open_in_neotree,
            { buffer = args.data.buf_id, desc = "open current entry in neotree", noremap = true }
          )
          vim.keymap.set("i", "<C-s>", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            require("mini.files").synchronize()
          end, { buffer = args.data.buf_id, desc = "synchronize " })
          -- vim.keymap.set("n", "gi", show_file_info, { buffer = args.data.buf_id, desc = "show file info" })
          vim.keymap.set(
            "n",
            "O",
            open_in_system,
            { buffer = args.data.buf_id, desc = "open in system", noremap = true }
          )
          vim.keymap.set(
            "n",
            "<localleader>D",
            go_to_directory,
            { buffer = args.data.buf_id, desc = "go to directory", noremap = true }
          )
        end,
      })
    end,
  },
}
