local os_name = require("utils.os_name")

return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          -- python = "python" .. (os_name == "windows" and ".exe" or ""),
        },
      },
    },
  },
}
