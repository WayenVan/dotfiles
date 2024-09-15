return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-emoji" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local types = require("cmp.types")

      -- modify default sources
      for _, source in ipairs(opts.sources) do
        if source.name == "path" then
          source.option = {
            get_cwd = function()
              return vim.fn.getcwd()
            end,
          }
        end
      end

      -- opts.mapping["<C-N>"] = cmp.config.disable
      -- opts.mapping["<C-P>"] = cmp.mapping.complete()
      -- opts.mapping["<C-P>"] = cmp.config.disable
      -- opts.mapping["<C-J>"] = cmp.mapping.select_next_item()
      -- opts.mapping["<C-K>"] = cmp.mapping.select_prev_item()
      opts.mapping["<CR>"] = cmp.config.disable
      opts.completeopt = "menu,menuone,noselect,noinsert"
      opts.confirmation = {
        default_behavior = types.cmp.ConfirmBehavior.Replace,
        get_commit_characters = function(commit_characters)
          return commit_characters
        end,
      }
    end,
  },
}
