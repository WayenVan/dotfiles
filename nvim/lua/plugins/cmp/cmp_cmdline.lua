return {
  {
    "hrsh7th/cmp-cmdline",
    event = "InsertEnter",
    dependencies = {
      "dmitmel/cmp-cmdline-history",
    },
    config = function()
      local cmp = require("cmp")
      local mapping = vim.deepcopy(cmp.mapping.preset.cmdline())
      local log = require("plenary.log"):new()
      log.info(mapping)
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = mapping,
        sources = cmp.config.sources({
          { name = "path" },
          -- { name = "cmdline_history" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
    vim.keymap.set("c", "<C-U>", "<Up>", { desc = "Navigate cmdline history up" }),
    vim.keymap.set("c", "<C-D>", "<Down>", { desc = "Navigate cmdline history down" }),
  },
  {
    "dmitmel/cmp-cmdline-history",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local mapping = vim.deepcopy(cmp.mapping.preset.cmdline())
      mapping["<S-Tab>"] = nil
      mapping["<Tab>"] = nil
      for _, cmd_type in ipairs({ "/", "?", "@" }) do
        cmp.setup.cmdline(cmd_type, {
          mapping = mapping,
          sources = {
            { name = "cmdline_history" },
          },
        })
      end
    end,
  },
}
