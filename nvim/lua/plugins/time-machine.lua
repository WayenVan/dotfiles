return {
  {
    "y3owk1n/time-machine.nvim",
    version = "*", -- remove this if you want to use the `main` branch
    init = function()
      vim.opt.undofile = true
      vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
    end,
    keys = {
      {
        "<leader>;",
        "<cmd>TimeMachineToggle<cr>",
        desc = "Toggle Time Machine",
      },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
