return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
      },
      sources = {
        cmdline = { "cmdline" },
        -- cmdline = function()
        --   local type = vim.fn.getcmdtype()
        --   -- Search forward and backward
        --   if type == "/" or type == "?" then
        --     return { "buffer" }
        --   end
        --   -- Commands
        --   if type == ":" then
        --     return { "cmdline" }
        --   end
        --   return {}
        -- end,
      },
    },
  },
}
