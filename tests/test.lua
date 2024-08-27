require("overseer").register_template({
  -- Required fields
  name = "My Task",
  builder = function(params)
    -- This must return an overseer.TaskDefinition
    return {
      -- cmd is the only required field
      cmd = { "echo" },
      -- additional arguments for the cmd
      args = { "hello", "world" },
      -- the name of the task (defaults to the cmd of the task)
      name = "Python",
      -- set the working directory for the task
      cwd = vim.fn.getcwd(),
      -- additional environment variables
      env = {
        VAR = "FOO",
      },
      -- the list of components or component aliases to add to the task
      -- components = { "my_custom_component", "default" },
      -- -- arbitrary table of data for your own personal use
      -- metadata = {
      --   foo = "bar",
      -- },
    }
  end,
})
