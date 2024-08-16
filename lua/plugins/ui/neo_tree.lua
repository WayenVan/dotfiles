return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>ue",
        function()
          require("neo-tree.command").execute({ toggle = true, action = "show" })
        end,
        desc = "Toggle NeoTree explore",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
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
      opts = function(_, opts)
        opts.window.mappings["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } }
        opts.window.mappings["l"] = "focus_preview"
        opts.window.mappings["<C-b>"] = { "scroll_preview", config = { direction = 10 } }
        opts.window.mappings["<C-f>"] = { "scroll_preview", config = { direction = -10 } }
      end,
    },
  },
}
