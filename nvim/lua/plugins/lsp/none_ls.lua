return {

  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.hover.printenv.with({
        filetypes = { "sh", "dosbatch", "ps1", "fish" },
      }),
    })
  end,
}
