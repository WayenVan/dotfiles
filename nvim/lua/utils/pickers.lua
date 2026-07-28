M = {}

function M.pick_directories(cwd, open)
  local Snacks = require("snacks")

  cwd = cwd or vim.fn.getcwd()
  cwd = vim.fs.normalize(vim.fn.expand(cwd))

  Snacks.picker.pick({
    title = "Directories: " .. cwd,
    cwd = cwd,
    format = "file",

    hidden = false,
    ignored = false,

    toggles = {
      hidden = "h",
      ignored = "i",
    },

    finder = function(opts, ctx)
      local args = {
        "--type",
        "d",
        "--color",
        "never",
        "--exclude",
        ".git",
      }

      if opts.hidden then
        table.insert(args, "--hidden")
      end

      if opts.ignored then
        table.insert(args, "--no-ignore")
      end

      table.insert(args, ".")

      return require("snacks.picker.source.proc").proc(
        ctx:opts({
          cmd = "fd",
          args = args,
          cwd = cwd,

          transform = function(item)
            item.file = item.text
            item.cwd = cwd
            item.dir = true
          end,
        }),
        ctx
      )
    end,

    actions = {
      notify_hidden = function(picker)
        vim.notify("Hidden directories: " .. (picker.opts.hidden and "enabled" or "disabled"), vim.log.levels.INFO, {
          title = "Directory Picker",
        })
      end,

      notify_ignored = function(picker)
        vim.notify(
          "Git-ignored directories: " .. (picker.opts.ignored and "enabled" or "disabled"),
          vim.log.levels.INFO,
          {
            title = "Directory Picker",
          }
        )
      end,
    },

    confirm = function(picker, item)
      picker:close()

      if not item then
        return
      end

      local path = vim.fs.normalize(vim.fs.joinpath(item.cwd, item.file))

      open(path)
    end,

    win = {
      input = {
        keys = {
          ["<A-h>"] = {
            { "toggle_hidden", "notify_hidden" },
            mode = { "n", "i" },
            desc = "Toggle hidden directories",
          },

          ["<A-i>"] = {
            { "toggle_ignored", "notify_ignored" },
            mode = { "n", "i" },
            desc = "Toggle git-ignored directories",
          },
        },
      },

      list = {
        keys = {
          ["<A-h>"] = {
            { "toggle_hidden", "notify_hidden" },
            desc = "Toggle hidden directories",
          },

          ["<A-i>"] = {
            { "toggle_ignored", "notify_ignored" },
            desc = "Toggle git-ignored directories",
          },
        },
      },
    },

    layout = {
      preset = "select",
      preview = false,
    },
  })
end

return M
