local misc = require("utils.misc")

vim.notify(misc.shellescape_dir("this directory \\\\ tto"))
