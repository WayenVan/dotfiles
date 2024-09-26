local M = {}

M.prompt_picker = function()
  local t = {
    pickers = require("telescope.pickers"),
    finders = require("telescope.finders"),
    sorters = require("telescope.sorters"),
    actions = require("telescope.actions"),
    previewers = require("telescope.previewers"),
    action_state = require("telescope.actions.state"),
    themes = require("telescope.themes"),
    conf = require("telescope.config").values,
  }
  local prompts = require("avante.prompt")
  local opts = t.themes.get_dropdown({})
  local finder = t.finders.new_dynamic({
    fn = function()
      local ret = {}
      for key, _ in pairs(prompts) do
        table.insert(ret, key)
      end
      return ret
    end,
  })

  local previewer = t.previewers.new_buffer_previewer({
    title = "Prompt Preview",
    define_preview = function(self, entry)
      local prompt = prompts[entry.value].prompt
      -- vim.notify(vim.inspect(prompt))
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, vim.split(prompt, "\n"))
    end,
  })
  t.pickers
    .new(opts, {
      prompt_title = "change avante prompt",
      finder = finder,
      previewer = previewer,
      sorter = t.conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        local select_prompt = function()
          local selection = t.action_state.get_selected_entry()
          local avante_config = require("avante.config")
          avante_config.override({ system_prompt = prompts[selection.value].prompt })
          vim.notify("prompt changed to " .. selection.value)
          t.actions.close(prompt_bufnr)
        end
        map("i", "<CR>", select_prompt)
        map("n", "<CR>", select_prompt)

        return true
      end,
    })
    :find()
end

return M
