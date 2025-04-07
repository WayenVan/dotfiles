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

      local Path = require("plenary.path")
      local MiniFiles = require("mini.files")
      local notify = require("noice").notify

      --- Utility functions ---
      local function get_entry_path()
        local entry = MiniFiles.get_fs_entry()
        return entry and entry.path or nil
      end

      local function yank_path(modifier, msg)
        local path = get_entry_path()
        if not path then
          return
        end
        local modified = vim.fn.fnamemodify(path, modifier)
        local os_name = require("utils.os_name").get_os_name()

        if os_name == "Windows" then
          vim.fn.setreg("+", modified)
        else
          vim.fn.setreg("", modified)
        end
        notify(msg:format(modified), "info")
      end

      --- Action implementations ---
      local function go_to_directory()
        local path = get_entry_path()
        if not path then
          return
        end

        if Path:new(path):is_dir() then
          vim.cmd.tcd(path)
        else
          notify("Not a directory", "error")
        end
      end

      local open_in_system = function()
        local path = Path:new(MiniFiles.get_fs_entry().path)
        if path:is_dir() then
          path = path:absolute()
          path = vim.fn.shellescape(path) -- Shorten the path to avoid long paths in Windows
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

      --- Keymap configurations ---
      local keymaps = {
        {
          "n",
          "gy",
          function()
            yank_path(":.", "Copied %s to unnamed")
          end,
          { desc = "Yank relative path" },
        },

        {
          "n",
          "gY",
          function()
            yank_path(":p", "Copied %s to unnamed")
          end,
          { desc = "Yank absolute path" },
        },

        {
          "n",
          "Y",
          function()
            yank_path(":t", "Copied %s to unnamed")
          end,
          { desc = "Yank filename" },
        },

        {
          "n",
          "gr",
          function()
            require("neo-tree.command").execute({
              action = "focus",
              position = "right",
              reveal_file = get_entry_path(),
              dir = vim.fn.getcwd(),
            })
          end,
          { desc = "Reveal in NeoTree" },
        },

        { "n", "O", open_in_system, { desc = "Open in system" } },
        { "n", "<localleader>D", go_to_directory, { desc = "Set CWD to directory" } },

        {
          "i",
          "<C-s>",
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            MiniFiles.synchronize()
          end,
          { desc = "Synchronize" },
        },
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          for _, map in ipairs(keymaps) do
            map[4] = vim.tbl_deep_extend("force", map[4] or {}, { buffer = args.data.buf_id })
            vim.keymap.set(map[1], map[2], map[3], map[4])
          end
        end,
      })
    end,
  },
}
