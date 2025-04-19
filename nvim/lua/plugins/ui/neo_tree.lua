return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    -- enabled = false,
    branch = "v3.x",
    lazy = true,
    keys = function(_, keys)
      return {
        {
          "<leader>R",
          function()
            require("neo-tree.command").execute({ action = "show", toggle = true, dir = LazyVim.root(), reveal = false })
          end,
          desc = "Explorer NeoTree (Root Dir)",
        },
        {
          "<leader>r",
          function()
            require("neo-tree.command").execute({ action = "show", toggle = true, dir = vim.uv.cwd(), reveal = false })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        {
          "<leader>f.",
          function()
            require("neo-tree.command").execute({ action = "show", toggle = false, dir = LazyVim.root(), reveal = true })
          end,
          desc = "Open in NeoTree (cwd)",
        },
        {
          "<leader>ge",
          function()
            require("neo-tree.command").execute({ source = "git_status", toggle = true })
          end,
          desc = "Git Explorer",
        },
        {
          "<leader>be",
          function()
            require("neo-tree.command").execute({ source = "buffers", toggle = true })
          end,
          desc = "Buffer Explorer",
        },
      }
    end,

    opts = function(_, opts)
      -- opts.window.position = "right"
      opts.window.mappings["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } }
      opts.window.mappings["l"] = "focus_preview"
      -- opts.window.mappings["<C-b>"] = { "scroll_preview", config = { direction = 10 } }
      -- opts.window.mappings["<C-f>"] = { "scroll_preview", config = { direction = -10 } }
      opts.window.mappings["-"] = "open_split"
      opts.window.mappings["_"] = "open_vsplit"
      opts.window.mappings["s"] = "none"
      -- opts.window.mappings["s"] = "none"
      -- opts.window.mappings["S"] = "none"
      vim.notify(vim.inspect(opts.filesystem))
      opts.filesystem.follow_current_file.enabled = false
      opts.filesystem.follow_current_file.leave_dirs_open = true
      opts.filesystem.filtered_items = {
        hide_dotfiles = false,
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    --
    opts = {
      -- add copy path command
      commands = {
        open_in_mini_file = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          require("mini.files").open(filepath)
        end,
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["BASENAME"] = modify(filename, ":r"),
            ["EXTENSION"] = modify(filename, ":e"),
            ["FILENAME"] = filename,
            ["PATH (CWD)"] = modify(filepath, ":."),
            ["PATH (HOME)"] = modify(filepath, ":~"),
            ["PATH"] = filepath,
            ["URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val)
            return vals[val] ~= ""
          end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item)
              return ("%s: %s"):format(item, vals[item])
            end,
          }, function(choice)
            local result = vals[choice]
            if result then
              if vim.fn.has("clipboard") == 0 then
                require("noice").notify("Clipboard is not available", "warn")
              end
              vim.notify(("Copied: `%s` to uname and plus register"):format(result))
              vim.fn.setreg('"', result)
              vim.fn.setreg("+", result)
            end
          end)
        end,
      },
      window = {
        title = "",
        mappings = {
          Y = "copy_selector",
          ["ge"] = "open_in_mini_file",
        },
      },
    },
  },
}
