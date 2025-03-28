return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      -- "nvimtools/hydra.nvim",
      { "igorlfs/nvim-dap-view" },
    },
    keys = {
      { "<leader>dR", "<cmd>lua require('dap').restart()<cr>", desc = "Restart" },
      { "<leader>da", "<cmd>DapNew<cr>", desc = "Create a new dap session" },
      { "<leader>dn", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over" },
      {
        "<leader>dS",
        function()
          local w = require("dap.ui.widgets")
          -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
          w.centered_float(w.sessions)
        end,
        desc = "Dap Sessions",
      },
      {
        "<leader>ds",
        function()
          local w = require("dap.ui.widgets")
          -- w.sidebar(w.sessions, {}, "5 sp | setl winfixheight").toggle()
          w.centered_float(w.scopes)
        end,
        desc = "Dap Scopes",
      },
      {
        "<leader>dv",
        function()
          require("dap.ui.widgets").hover(nil, { border = "single" })
        end,
        desc = "Dap Evaluate",
      },
    },

    opts = function()
      -- require custom configuration
      local customized_configuration = {
        python = "plugins.dap.configs.python",
      }
      for name, module in pairs(customized_configuration) do
        require(module)
      end

      -- auto command for filetype dap-float
      vim.api.nvim_create_augroup("Dap_", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = "Dap_",
        pattern = { "dap-float" },
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.api.nvim_buf_set_keymap(buf, "n", "q", "<CMD>q<CR>", { noremap = true, silent = true })
        end,
      })

      -- setting the start of hydra dap mode
      local dap = require("dap")
      dap.listeners.before.attach["submode"] = function()
        require("submode").enter("Debug")
      end
      dap.listeners.before.launch["submode"] = function()
        require("submode").enter("Debug")
      end
      dap.listeners.after.event_terminated["submode"] = function()
        --send key to exit hydra
        if require("dap").session() == nil then
          require("submode").leave()
        end
      end

      dap.listeners.after.event_exited["submode"] = function()
        if require("dap").session() == nil then
          require("submode").leave()
        end
      end

      --jump to the window if

      -- 监听 DAP 断点事件
      dap.listeners.before.event_stopped["jump_to_existing_buffer"] = function(session, body)
        if not body.threadId then
          return
        end

        session:request("stackTrace", { threadId = body.threadId }, function(err, response)
          if err then
            vim.notify("Error getting stack: " .. vim.inspect(err), vim.log.levels.ERROR)
            return
          end

          if response and response.stackFrames and #response.stackFrames > 0 then
            local top_frame = response.stackFrames[1]
            if top_frame.source and top_frame.line then
              local filepath = top_frame.source.path or top_frame.source.name
              local target_line = top_frame.line

              -- 标准化路径（避免因路径格式不同导致匹配失败）
              filepath = vim.fn.fnamemodify(filepath, ":p")

              -- 检查文件是否已在当前 Tab 的窗口中打开
              for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buf_path = vim.api.nvim_buf_get_name(buf)
                buf_path = vim.fn.fnamemodify(buf_path, ":p")

                -- 如果找到已打开的窗口
                if buf_path == filepath then
                  print(string.format("Open file founded, stop at %s:%d", filepath, target_line))
                  vim.api.nvim_set_current_win(win) -- 跳转到该窗口
                  vim.api.nvim_win_set_cursor(win, { target_line, 0 }) -- 定位到断点行
                  return -- 结束处理
                end
              end
            end
          end
        end)
      end
    end,
    --   config = function()
    --     -- load mason-nvim-dap here, after all adapters have been setup
    --     if LazyVim.has("mason-nvim-dap.nvim") then
    --       require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    --     end
    --
    --     vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    --     for name, sign in pairs(LazyVim.config.icons.dap) do
    --       sign = type(sign) == "table" and sign or { sign }
    --       vim.fn.sign_define(
    --         "Dap" .. name,
    --         { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --       )
    --     end
    --
    --     -- setup dap config by VsCode launch.json file
    --     local vscode = require("dap.ext.vscode")
    --     local json = require("plenary.json")
    --     vscode.json_decode = function(str)
    --       return vim.json.decode(json.json_strip_comments(str))
    --     end
    --
    --     -- Extends dap.configurations with entries read from .vscode/launch.json
    --     if vim.fn.filereadable(".vscode/launch.json") then
    --       vscode.load_launchjs()
    --     end
    --
    --     -- setting keymaps for session selection
    --     vim.keymap.set("n", "<leader>ds", function()
    --       if #require("dap").sessions() == 0 then
    --         require("noice").notify("No dap session running", "info")
    --         return
    --       end
    --       local ui = require("dap.ui.widgets")
    --       local s = ui.sessions
    --       ui.cursor_float(s, {})
    --     end, { desc = "Sessions" })
    --     -- set auto command for session window
    --     vim.api.nvim_create_augroup("Dap_", { clear = true })
    --     vim.api.nvim_create_autocmd({ "FileType" }, {
    --       group = "Dap_",
    --       pattern = { "dap-float" },
    --       callback = function()
    --         local buf = vim.api.nvim_get_current_buf()
    --         vim.api.nvim_buf_set_keymap(buf, "n", "q", "<CMD>q<CR>", { noremap = true, silent = true })
    --       end,
    --     })
    --
    --     -- add custom dap configuration, should run
    --     local customized_configuration = {
    --       python = "plugins.dap.configs.python",
    --     }
    --     for name, module in pairs(customized_configuration) do
    --       require(module)
    --     end
    --   end,
  },
}
