return {
  {
    "dmtrKovalenko/fff.nvim",
    lazy = true,
    enabled = true,
    build = "cargo build --release",
    -- or if you are using nixos
    -- build = "nix run .#release",
    opts = {
      -- pass here all the options
      prompt = " ",
      layout = {
        prompt_position = "top", -- or "bottom"
      },
      keymaps = {
        close = "<c-q>",
      },
    },
    keys = {
      {
        "<leader><space>", -- try it if you didn't it is a banger keybinding for a picker
        function()
          require("fff").find_files() -- or find_in_git_root() if you only want git files
        end,
        desc = "Open file picker",
      },
      {
        "<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          require("fff").find_files_in_dir(LazyVim.root({ buf = bufnr })) -- or find_in_git_root() if you only want git files
        end,
        desc = "Open file picker in lazyvim root",
      },
    },
    config = function(_, opts)
      require("fff").setup(opts)
      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = { "fff_input" },
        group = vim.api.nvim_create_augroup("FFFInput", { clear = true }),
        callback = function(ev)
          vim.keymap.set("n", "<esc>", function()
            require("fff.picker_ui").close()
          end, { buffer = ev.buf, nowait = true })
        end,
      })
    end,
  },
}
