return {
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    -- still buggy
    -- enabled = false,
    dependencies = { "folke/snacks.nvim" },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      -- {
      --   "<leader>-",
      --   mode = { "n", "v" },
      --   "<cmd>Yazi<cr>",
      --   desc = "Open yazi at the current file",
      -- },
      {
        "<leader>-",
        function()
          require("snacks")

          Snacks.terminal("yazi", {
            win = {

              border = "single",
              keys = {
                term_normal = {
                  "<esc>",
                  function(self)
                    return "<esc>"
                  end,
                  mode = "t",
                  expr = true,
                  desc = "Double escape to normal mode",
                },
              },
            },
          })
        end,
        desc = "Resume the last yazi session",
      },
    },
    -- ---@type YaziConfig | {}
    -- opts = {
    --   -- if you want to open yazi instead of netrw, see below for more info
    --   open_for_directories = false,
    --   keymaps = {
    --     show_help = "<f1>",
    --   },
    -- },
    -- -- 👇 if you use `open_for_directories=true`, this is recommended
    -- init = function()
    --   -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    --   -- vim.g.loaded_netrw = 1
    --   vim.g.loaded_netrwPlugin = 1
    -- end,

    config = function(_, opts) end,
  },
}
