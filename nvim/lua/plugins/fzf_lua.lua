return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader>,",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      -- find
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      -- { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      -- { "<leader>fF", LazyVim.pick("files"{ root = false }), desc = "Find Files (cwd)" },
      { "<leader>ff", false },
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    },
  },
}
