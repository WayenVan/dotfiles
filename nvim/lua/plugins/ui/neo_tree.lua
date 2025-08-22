return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    enabled = true,
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
      opts.window.mappings["S"] = "open_split"
      opts.window.mappings["V"] = "open_vsplit"
      opts.window.mappings["s"] = "none"
      -- opts.window.mappings["s"] = "none"
      -- opts.window.mappings["S"] = "none"
      opts.filesystem.follow_current_file.enabled = false
      opts.filesystem.follow_current_file.leave_dirs_open = true
      opts.filesystem.filtered_items = {
        hide_dotfiles = false,
      }

      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = { "neo-tree-popup" },
        group = vim.api.nvim_create_augroup("Neotree-Popup", { clear = true }),
        callback = function(ev)
          vim.keymap.set("n", "q", "<c-w>q", { buffer = ev.buf, nowait = true })
        end,
      })
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
          require("utils.yank_path").yank_path_picker(filepath)
        end,
        copy_relative_path = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          require("utils.yank_path").yank_path(":t", filepath)
        end,
        copy_absolute_path = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          require("utils.yank_path").yank_path(":p", filepath)
        end,
      },
      window = {
        title = "",
        mappings = {
          Y = "copy_selector",
          ["gy"] = "copy_relative_path",
          ["gY"] = "copy_absolute_path",
          ["ge"] = "open_in_mini_file",
          ["/"] = "none", -- disable search
          ["<esc>"] = "none",
        },
      },
    },
  },
}
