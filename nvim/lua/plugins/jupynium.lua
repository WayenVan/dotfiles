return {
  {
    "kiyoon/jupynium.nvim",
    lazy = true,
    enabled = false,
    ft = {
      "python",
    },
    build = "pip3 install --user .",
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
    -- use_default_keymap = false,
    config = function(_, opts)
      require("jupynium").setup(opts)
      local options = require("jupynium.options")
    end,
  },
}
