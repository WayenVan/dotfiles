local submode = require("submode")
-- debug submode
vim.keymap.set("n", "<leader>W", function()
  submode.enter("Window")
end, { desc = "Enter debug mode" })
submode.create("Window", {
  mode = "n",
  enter = nil,
  leave = { "<Esc>", "q" },
  default = function(register)
    -- scope
    register("h", function()
      require("smart-splits").resize_left()
    end, { desc = "resize left" })
    register("l", function()
      require("smart-splits").resize_right()
    end, { desc = "resize right" })
    register("j", function()
      require("smart-splits").resize_down()
    end, { desc = "resize down" })
    register("k", function()
      require("smart-splits").resize_up()
    end, { desc = "resize up" })
  end,
})
