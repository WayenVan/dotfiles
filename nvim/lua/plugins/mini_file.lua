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
        "<leader>Oc",
        function()
          local path = require("plenary.path"):new(vim.fn.stdpath("cache")):absolute()
          require("mini.files").open(path, true, {})
        end,
        desc = "Open mini.files (cache)",
      },
      {
        "<leader>Os",
        function()
          local path = require("plenary.path"):new(vim.fn.stdpath("state")):absolute()
          require("mini.files").open(path, true, {})
        end,
        desc = "Open mini.files (state)",
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
        synchronize = "<C-s>",
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

      local yank_path = require("utils.yank_path").yank_path

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
          path = require("utils.misc").shellescape_dir(path)
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
            -- vim.cmd("silent !start " .. path)
            vim.cmd("silent !start " .. path)
          else
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
            yank_path(":t", get_entry_path())
          end,
          { desc = "Yank relative path" },
        },

        {
          "n",
          "gY",
          function()
            yank_path(":p", get_entry_path())
          end,
          { desc = "Yank absolute path" },
        },

        {
          "n",
          "Y",
          function()
            local path = get_entry_path()
            MiniFiles.close()
            require("utils.yank_path").yank_path_picker(path)
          end,
          { desc = "Yank filename" },
        },

        {
          "n",
          "gr",
          function()
            require("neo-tree.command").execute({
              action = "focus",
              position = "left",
              reveal_file = get_entry_path(),
              dir = vim.fn.getcwd(),
            })
          end,
          { desc = "Reveal in NeoTree" },
        },

        -- { "n", "O", open_in_system, { desc = "Open in system" } },
        { "n", "<localleader>D", go_to_directory, { desc = "Set CWD to directory" } },
        {
          "n",
          "K",
          function()
            local path = get_entry_path()
            local current_cursor_pos = vim.api.nvim_win_get_cursor(0)
            require("utils.file_info").show_file_info(path, {
              col = current_cursor_pos[2],
              row = current_cursor_pos[1],
              zindex = 1001,
              enter = false,
            }, true)
          end,
          {},
        },
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
