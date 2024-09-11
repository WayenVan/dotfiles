-- this file auto run after lazya configed
-- filetype
vim.filetype.add({
  filename = {
    [".condarc"] = "yaml", -- Set filetype to 'python' for a file named 'mycustomfile'
    [".fishrc"] = "fish",
  },
  extension = {},
  pattern = {},
})

require("utils.auto_source").setup()
require("utils.storage").setup()
require("utils.server").setup()
