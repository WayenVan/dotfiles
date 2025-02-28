-- vim.g.lazyvim_blink_main = true
return {
  {
    "saghen/blink.cmp",
    event = function(_, event)
      return vim.list_extend(event, { "CmdlineEnter" })
    end,
    opts = {
      keymap = {
        preset = "default",
        ["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
      },
      cmdline = {
        enabled = true,
        keymap = { preset = "cmdline" },
        sources = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = {},
          },
          list = {
            selection = {
              -- When `true`, will automatically select the first item in the completion list
              preselect = true,
              -- When `true`, inserts the completion item automatically when selecting it
              auto_insert = true,
            },
          },
          -- Whether to automatically show the window when new completion items are available
          menu = { auto_show = true },
          -- Displays a preview of the selected item on the current line
          ghost_text = { enabled = true },
        },
      },
    },
  },
}
