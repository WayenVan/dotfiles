return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    dependencies = { { "folke/which-key.nvim" } },
    cmd = { "ToggleTerm" },
    keys = {
      { "<leader>T", "", desc = "toggle terminal" },
      {
        "<c-_>",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 0, LazyVim.root.get())
        end,
        desc = "ToggleTerm",
        mode = { "n", "i" },
      },
      {
        "<c-/>",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 0, LazyVim.root.get())
        end,
        noremap = true,
        desc = "ToggleTerm",
        mode = { "n", "i" },
      },
      {
        "<leader>Tf",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 15, LazyVim.root.get(), "float")
        end,
        desc = "ToggleTerm (float root_dir)",
      },
      {
        "<leader>Ts",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 15, LazyVim.root.get(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal root_dir)",
      },
      {
        "<leader>Tv",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, vim.o.columns * 0.4, LazyVim.root.get(), "vertical")
        end,
        desc = "ToggleTerm (vertical root_dir)",
      },
      {
        "<leader>Tn",
        "<cmd>ToggleTermSetName<cr>",
        desc = "Set term name",
      },
      {
        "<leader>Tt",
        "<cmd>TermSelect<cr>",
        desc = "Select term",
      },
      {
        "<leader>Tc",
        function()
          require("utils.term").clear_all()
        end,
        desc = "Clear all terms",
      },
      -- lazygit
      {
        "<leader>gl",
        function()
          require("utils.term").lazygit_cwd()
        end,
        desc = "lazygit (cwd)",
      },
      {
        "<leader>gL",
        function()
          require("utils.term").lazygit_root()
        end,
        desc = "lazygit (root)",
      },
      -- {
      --   "<leader>gl",
      --   function()
      --     require("utils.term").lazygit_log_cwd()
      --   end,
      --   desc = "lazygit log (cwd)",
      -- },
      -- {
      --   "<leader>gL",
      --   function()
      --     require("utils.term").lazygit_log_root()
      --   end,
      --   desc = "lazygit log (root)",
      -- },
      -- {
      --   "<leader>Tt",
      --   function()
      --     require("toggleterm").toggle(1, 100, LazyVim.root.get(), "tab")
      --   end,
      --   desc = "ToggleTerm (tab root_dir)",
      -- },
      -- {
      --   "<leader>TT",
      --   function()
      --     require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
      --   end,
      --   desc = "ToggleTerm (tab cwd_dir)",
      -- },
    },
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      highlights = {
        Normal = {
          link = "Normal",
        },
      },
      open_mapping = [[<c-\>]],
      -- on_open = fun(t: Terminal), -- function to run when the terminal opens
      -- on_close = fun(t: Terminal), -- function to run when the terminal closes
      -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
      -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
      -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
      on_open = function(t)
        vim.cmd("startinsert")
      end,
      --- @param t Terminal
      on_create = function(t)
        --- check python venv
        if t.cmd == nil then
          local venv_info, _ = require("utils.venv")
          if venv_info ~= "none" then
            if venv_info.type == "conda" and venv_info.name == "base" then
              return
            end
            require("toggleterm").exec(venv_info.activate_cmd, t.id)
          end
        end
      end,
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = -30,
      -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      persist_mode = false,
      direction = "float" or "horizontal" or "vertical" or "window",
      -- direction = "float",
      close_on_exit = false, -- close the terminal window when the process exits

      -- shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- number = 1,
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function(_, opts)
      require("toggleterm").setup(opts)
      vim.api.nvim_create_augroup("ToggleTerm", { clear = true })
      -- Close all git terminals when session closes
      vim.api.nvim_create_autocmd({ "DirChanged" }, {
        group = "ToggleTerm",
        callback = function()
          require("utils.term").clear_storage()
        end,
      })
    end,
  },
}
