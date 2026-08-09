local Icons = require "utils.class.icon"
local fs = require("utils.fn").fs

local Config = {}

if fs.platform().is_win then
  Config.default_prog =
    { "pwsh", "-NoLogo", "-ExecutionPolicy", "RemoteSigned", "-NoProfileLoadTime" }

  Config.launch_menu = {
    {
      label = Icons.Progs["pwsh.exe"] .. " PowerShell V7",
      args = {
        "pwsh",
        "-NoLogo",
        "-ExecutionPolicy",
        "RemoteSigned",
        "-NoProfileLoadTime",
      },
      cwd = "~",
    },
    {
      label = Icons.Progs["pwsh.exe"] .. " PowerShell V5",
      args = { "powershell" },
      cwd = "~",
    },
    { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
    { label = Icons.Progs["git"] .. " Git bash", args = { "sh", "-l" }, cwd = "~" },
  }
end

Config.default_cwd = fs.home()

return Config
