return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart find files (cwd)",
    },
    { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>/", LazyVim.pick("grep", { root = false }), desc = "Grep (cwd)" },
    {
      "<leader>=",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>?",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader><",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffer Lines",
    },
  },
  opts = {
    notifier = {
      timeout = 1500,
      top_down = false,
    },
    scroll = {
      filter = function(buf)
        return vim.g.neovide == nil
          and vim.g.snacks_scroll ~= false
          and vim.b[buf].snacks_scroll ~= false
          and vim.bo[buf].buftype ~= "terminal"
      end,
    },
    dashboard = {
      preset = {
        header = [[
██╗   ██╗██╗ █████╗        ██╗   ██╗███████╗██████╗ ██╗████████╗ █████╗ ███████╗       ██╗   ██╗██╗████████╗ █████╗     
██║   ██║██║██╔══██╗       ██║   ██║██╔════╝██╔══██╗██║╚══██╔══╝██╔══██╗██╔════╝       ██║   ██║██║╚══██╔══╝██╔══██╗    
██║   ██║██║███████║       ██║   ██║█████╗  ██████╔╝██║   ██║   ███████║███████╗       ██║   ██║██║   ██║   ███████║    
╚██╗ ██╔╝██║██╔══██║       ╚██╗ ██╔╝██╔══╝  ██╔══██╗██║   ██║   ██╔══██║╚════██║       ╚██╗ ██╔╝██║   ██║   ██╔══██║    
 ╚████╔╝ ██║██║  ██║▄█╗     ╚████╔╝ ███████╗██║  ██║██║   ██║   ██║  ██║███████║▄█╗     ╚████╔╝ ██║   ██║   ██║  ██║    
  ╚═══╝  ╚═╝╚═╝  ╚═╝╚═╝      ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝      ╚═══╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝    
                                                                                                                        
                  TALK IS CHEAP. SHOW ME THE CODE.
                            
    ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          {
            action = ":Autosession search",
            desc = "Restore Session",
            icon = " ",
            key = "--",
          },
        },
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
