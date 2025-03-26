return {
  {
    "Bekaboo/dropbar.nvim",
    opts = {
      menu = {
        preview = false,
        win_configs = {
          border = "none",
        },
      },
    },
    config = function(_, opts)
      local valid_types = require("dropbar.configs").opts.sources.treesitter.valid_types

      for i, t in ipairs(valid_types) do
        if t == "module" then
          table.remove(valid_types, i)
          break
        end
      end
      require("dropbar").setup(opts)
    end,
  },
}
