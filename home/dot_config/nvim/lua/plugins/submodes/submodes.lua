local func = require("vim.func")
return {
  {
    "pogyomo/submode.nvim",
    -- do not need to load it immediately
    lazy = true,
    init = function()
      vim.keymap.set("n", "<leader>bd", function()
        local submode = require("submode")
        local mode = submode.mode()
        if mode ~= nil then
          submode.leave()
          Snacks.bufdelete.other()
          submode.enter(mode)
          return
        end
        Snacks.bufdelete.other()
      end, { desc = "Delete Other BUffers" })
      require("plugins.submodes.modes.debug")
      -- require("plugins.submodes.modes.repl")
      -- require("plugins.submodes.modes.tex")
      -- require("plugins.submodes.modes.window")
    end,
    -- (recommended) specify version to prevent unexpected change.
    -- version = "6.0.0",
  },
}
