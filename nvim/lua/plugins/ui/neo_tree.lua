return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    -- enabled = false,
    lazy = true,
    keys = function(_, keys)
      return {
        {
          "<leader>r",
          function()
            require("neo-tree.command").execute({
              action = "show",
              toggle = true,
              position = "right",
              dir = LazyVim.root(),
              reveal = false,
            })
          end,
          desc = "Toggle NeoTree explore",
        },
        {
          "<leader>R",
          function()
            require("neo-tree.command").execute({
              action = "show",
              toggle = false,
              position = "right",
              dir = LazyVim.root(),
              reveal = true,
            })
          end,
          desc = "Toggle NeoTree explore",
        },
      }
    end,

    -- keys = {
    -- {
    --   "<leader>fE",
    --   function()
    --     require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
    --   end,
    --   desc = "Explorer NeoTree (Root Dir)",
    -- },
    -- {
    --   "<leader>fe",
    --   function()
    --     require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
    --   end,
    --   desc = "Explorer NeoTree (cwd)",
    -- },
    -- { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
    -- { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
    -- {
    --   "<leader>ge",
    --   function()
    --     require("neo-tree.command").execute({ source = "git_status", toggle = true })
    --   end,
    --   desc = "Git Explorer",
    -- },
    -- {
    --   "<leader>be",
    --   function()
    --     require("neo-tree.command").execute({ source = "buffers", toggle = true })
    --   end,
    --   desc = "Buffer Explorer",
    -- },
    opts = function(_, opts)
      opts.window.position = "right"
      opts.window.mappings["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } }
      opts.window.mappings["l"] = "focus_preview"
      -- opts.window.mappings["<C-b>"] = { "scroll_preview", config = { direction = 10 } }
      -- opts.window.mappings["<C-f>"] = { "scroll_preview", config = { direction = -10 } }
      opts.window.mappings["-"] = "open_split"
      opts.window.mappings["_"] = "open_vsplit"
      -- opts.window.mappings["s"] = "none"
      -- opts.window.mappings["S"] = "none"
      opts.filesystem.follow_current_file.enable = false
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- show hide_files
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
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
