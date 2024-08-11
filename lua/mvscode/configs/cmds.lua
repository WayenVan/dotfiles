local api = vim.api
local vs = require("vscode-neovim")

api.nvim_create_user_command(
    'Outputs',
    function(opts)
        vs.action("workbench.action.output.show.asvetliakov.vscode-neovim.vscode-neovim logs")
    end,
    {nargs = 0}
)

api.nvim_create_user_command(
    'GoBack',
    function(opts)
        vs.action("workbench.action.navigateBack")
    end,
    {nargs = 0}
)

api.nvim_create_user_command(
    'GoForward',
    function(opts)
        vs.action("workbench.action.navigateForward")
    end,
    {nargs = 0}
)

api.nvim_create_user_command(
    'DebugConsole',
    function(opts)
        vs.action("workbench.panel.repl.view.focus")
    end,
    {nargs = 0}
)
