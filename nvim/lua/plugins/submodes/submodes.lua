local func = require("vim.func")
return {
  {
    "pogyomo/submode.nvim",
    -- do not need to load it immediately
    lazy = true,
    init = function()
      local submode = require("submode")
      -- debug submode
      submode.create("DEBUG", {
        mode = "n",
        enter = "<leader>Q",
        leave = { "<C-c>", "q" },
        default = function(register)
          -- scope
          register("<localleader>s", function()
            local w = require("dap.ui.widgets")
            -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
            w.centered_float(w.scopes)
          end, { desc = "Dap Scopes" })

          -- scope
          register("<localleader>S", function()
            require("dap.ui.widgets").hover(nil, { border = "single" })
          end, { desc = "Dap Evaluate" })
        end,
      })

      submode.create("DRAW", {
        mode = "n",
        enter = "<leader>D",
        leave = { "<C-c>", "q" },
        hooks = {
          on_enter = function()
            vim.keymap.set("v", "f", ":VBox<CR>", { noremap = true, silent = true })
          end,
          on_exit = function()
            vim.keumap.del("v", "f")
          end,
        },

        default = function(register)
          -- scope
          register("H", "<C-v>h:VBox<CR>", { desc = "←" })
          register("J", "<C-v>j:VBox<CR>", { desc = "↓" })
          register("K", "<C-v>k:VBox<CR>", { desc = "↑" })
          register("L", "<C-v>l:VBox<CR>", { desc = "→" })
          register("<C-h>", "xi<C-v>u25c4<Esc>", { desc = "◄" }) -- mode = 'v' somehow breaks
          register("<C-j>", "xi<C-v>u25bc<Esc>", { desc = "▼" })
          register("<C-k>", "xi<C-v>u25b2<Esc>", { desc = "▲" })
          register("<C-l>", "xi<C-v>u25ba<Esc>", { desc = "►" })
          register("f", ":VBox<CR>", { desc = "box" })
        end,
      })
    end,
    -- (recommended) specify version to prevent unexpected change.
    -- version = "6.0.0",
  },
}
