local misc = require("utils.misc")

-- vim.notify(misc.shellescape_dir("this directory \\\\ tto"))
--
--
print(vim.inspect(vim.lsp.get_active_clients()))
