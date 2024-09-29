local M = {}
M.prompt_picker_fzf = function()
  local fzf_lua = require("fzf-lua")
  local builtin = require("fzf-lua.previewer.builtin")

  -- Inherit from "base" instead of "buffer_or_file"
  local MyPreviewer = builtin.base:extend()

  function MyPreviewer:new(o, opts, fzf_win)
    MyPreviewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
  end

  function MyPreviewer:populate_preview_buf(entry_str)
    local tmpbuf = self:get_tmp_buffer()
    vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, {
      string.format("SELECTED FILE: %s", entry_str),
    })
    self:set_preview_buf(tmpbuf)
    self.win:update_scrollbar()
  end

  -- Disable line numbering and word wrap
  function MyPreviewer:gen_winopts()
    local new_winopts = {
      wrap = false,
      number = false,
    }
    return vim.tbl_extend("force", self.winopts, new_winopts)
  end

  fzf_lua.fzf_exec("rg --files", {
    previewer = MyPreviewer,
    prompt = "Select file> ",
  })
end

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
