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
        if not path then return end
        local modified = vim.fn.fnamemodify(path, modifier)
        vim.fn.setreg("", modified)
        notify(msg:format(modified), "info")
      end

      local function get_system_open_cmd(path)
        local os_name = require("utils.os_name").get_os_name()
        local is_dir = Path:new(path):is_dir()

        if os_name == "Mac" then
          return is_dir and {"open", path} or {"open", "-R", path}
        elseif os_name == "Linux" then
          return {"xdg-open", path}
        elseif os_name == "Windows" then
          return {"cmd", "/c", "start", (is_dir and "" or "/select"), path}
        end
      end

      --- Action implementations ---
      local function go_to_directory()
        local path = get_entry_path()
        if not path then return end
        
        if Path:new(path):is_dir() then
          vim.cmd.tcd(path)
        else
          notify("Not a directory", "error")
        end
      end

      local function open_in_system()
        local path = get_entry_path()
        if not path then return end

        local cmd = get_system_open_cmd(path)
        if not cmd then
          notify("Unsupported OS", "error")
          return
        end

        if vim.fn.has("win32") == 1 then
          vim.cmd("silent !start " .. table.concat(cmd, " "))
        else
          vim.fn.jobstart(cmd, { detach = true })
        end
      end

      --- Keymap configurations ---
      local keymaps = {
        { "n", "gy", function() yank_path(":.", "Copied %s to unnamed") end,
          { desc = "Yank relative path" } },
          
        { "n", "gY", function() yank_path(":p", "Copied %s to unnamed") end,
          { desc = "Yank absolute path" } },
          
        { "n", "Y",  function() yank_path(":t", "Copied %s to unnamed") end,
          { desc = "Yank filename" } },
          
        { "n", "gr", function()
            require("neo-tree.command").execute({
              action = "focus",
              position = "right",
              reveal_file = get_entry_path(),
              dir = vim.fn.getcwd()
            })
          end, { desc = "Reveal in NeoTree" } },
          
        { "n", "O", open_in_system, { desc = "Open in system" } },
        { "n", "<localleader>D", go_to_directory, { desc = "Set CWD to directory" } },
          
        { "i", "<C-s>", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            MiniFiles.synchronize()
          end, { desc = "Synchronize" } }
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          for _, map in ipairs(keymaps) do
            vim.keymap.set(unpack(map, 1, 4), { buffer = args.data.buf_id })
          end
        end
      })
    end,
  },
}
