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
    },
    -- {
    --   "nvim-neo-tree/neo-tree.nvim",
    --   opts = function(_, opts)
    --     -- Lua function to change the working directory to the currently selected item in Neo-tree
    --
    --     -- Create a command to change the working directory to the Neo-tree selected item
    --     vim.keymap.set("n", "<leader>fC", function()
    --       -- Get the current node in Neo-tree
    --       local node = require("neo-tree").sources.filesystem.get_node_under_cursor()
    --
    --       -- If the selected node is a directory, use its path
    --       -- Otherwise, use the parent directory's path
    --       local path = node.path
    --       if node.type ~= "directory" then
    --         path = vim.fn.fnamemodify(path, ":h")
    --       end
    --
    --       -- Change Neovim's working directory to the selected path
    --       vim.cmd("cd " .. path)
    --       print("Working directory changed to: " .. path)
    --     end, { noremap = true, silent = true, desc = "Change working directory to Neo-tree item" })
    --     return opts
    --   end,
    -- },
  },
}
