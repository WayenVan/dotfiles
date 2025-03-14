return {
  {
    "kkharji/sqlite.lua",
    enabled = false,
    init = function()
      if require("utils.os_name").get_os_name() == "Windows" then
        local clib_path = require("plenary.path"):new(vim.fn.stdpath("data")):joinpath("sqlite3.dll")
        if clib_path:exists() then
          vim.g.sqlite_clib_path = clib_path:absolute()
          return
        end
        vim.notify(
          "sqlite3.dll not found, please download it from https://www.sqlite.org/download.html and place it in "
            .. clib_path:parent():absolute()
        )
      end
    end,
  },
}
