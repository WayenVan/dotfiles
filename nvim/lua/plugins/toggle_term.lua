_G.Last_toggle_term_id = nil

local function toggle_with_prevous(dir, direction, size)
  size = size or 0
  if vim.v.count == 0 and Last_toggle_term_id ~= nil then
    require("toggleterm").toggle(Last_toggle_term_id, size, dir, direction)
    return
  end
  require("toggleterm").toggle(vim.v.count, size, dir, direction)
end

return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    dependencies = { { "folke/which-key.nvim" } },
    cmd = { "ToggleTerm" },
    keys = {
      { "<leader>-", "", desc = "toggle terminal" },
      {
        "<c-_>",
        function()
          toggle_with_prevous(LazyVim.root.get())
        end,
        desc = "ToggleTerm",
        mode = { "n", "i" },
      },
      {
        "<c-/>",
        function()
          toggle_with_prevous(LazyVim.root.get())
        end,
        noremap = true,
        desc = "ToggleTerm",
        mode = { "n", "i" },
      },
      {
        "<leader>-f",
        function()
          toggle_with_prevous(LazyVim.root.get(), "float")
        end,
        desc = "ToggleTerm (float root_dir)",
      },
      {
        "<leader>-s",
        function()
          toggle_with_prevous(LazyVim.root.get(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal root_dir)",
      },
      {
        "<leader>-v",
        function()
          toggle_with_prevous(LazyVim.root.get(), "vertical", vim.o.columns * 0.5)
        end,
        desc = "ToggleTerm (vertical root_dir)",
      },
      {
        "<leader>-n",
        "<cmd>ToggleTermSetName<cr>",
        desc = "Set term name",
      },
      {
        "<leader>--",
        "<cmd>TermSelect<cr>",
        desc = "Select term",
      },
      {
        "<leader>-c",
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
      {
        "<leader>a/",
        function()
          require("utils.term").create_aider()
        end,
        desc = "aider (cwd>)",
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
      --   "<leader>-t",
      --   function()
      --     require("toggleterm").toggle(1, 100, LazyVim.root.get(), "tab")
      --   end,
      --   desc = "ToggleTerm (tab root_dir)",
      -- },
      -- {
      --   "<leader>-T",
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
          return vim.o.columns * 0.5
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
        -- remember the laast opened terminal
        -- vim.notify(t.id)
        if Last_toggle_term_id ~= nil and Last_toggle_term_id ~= t.id then
          Last_toggle_term_id = t.id
          return
        end
        Last_toggle_term_id = t.id
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
      on_exit = function(t)
        -- remove the last opened terminal
        if Last_toggle_term_id == t.id then
          Last_toggle_term_id = nil
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

      -- Setup keymaps for all terminal
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        group = "ToggleTerm",
        callback = function()
          -- Set terminal-local keymaps
          -- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = 0 }) -- Exit terminal mode with Esc
          vim.keymap.set("t", "\\\\", [[<C-\><C-n>]], { buffer = 0 })
          vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { buffer = 0 }) -- Move left
          vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { buffer = 0 }) -- Move down
          vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { buffer = 0 }) -- Move up
          vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { buffer = 0 }) -- Move right
        end,
      })
    end,
  },
}
