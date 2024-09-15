return {
  desc = "Change the compiler",
  editable = true,
  params = {
    compiler = {
      type = "string",
      -- Optional fields that are available on any type
      order = 1, -- determines order of parameters in the UI
      optional = false, -- whether the parameter is required
      default = "",
    },
  },
  constructor = function(params)
    return {
      ---@param status overseer.Status Can be CANCELED, FAILURE, or SUCCESS
      ---@param result table A result table.
      on_start = function(self, task)
        if params.compiler == "" then
          return require("noice").notify("on_start_change_compiler is set but no compiler in params", "warn")
        end
        vim.cmd("compiler " .. params.compiler)
        require("noice").notify("set compiler to python", "info")
      end,
    }
  end,
}
