local manager = require("fyler.manager").get_manager()
local tab_id = vim.api.nvim_get_current_tabpage()
local tabs = vim.api.nvim_list_tabpages()
vim.notify(vim.inspect(tabs))
vim.notify("Current tab id: " .. tab_id)

-- for tab_id, id in ipairs(manager.tab_to_id) do
-- 	vim.notify("tab_id: " .. tab_id .. " -> explorer_id: " .. id)
-- end

-- vim.notify(vim.inspect(manager.tab_to_id))
-- vim.notify(vim.inspect(vim.tbl_keys(manager.instances)))
vim.notify(vim.inspect(vim.tbl_values(manager.tab_to_id)))
vim.notify(vim.inspect(vim.tbl_keys(manager.tab_to_id)))
-- for id, ins in pairs(manager.instances) do
-- 	vim.notify("explorer_id: " .. id)
-- end
-- require("multinput").setup()
-- vim.ui.input({ prompt = "Enter value for shiftwidth: " }, function(input)
-- 	vim.o.shiftwidth = tonumber(input)
-- end)
--
-- local dap = require("dap")
--
-- local all_highlights = vim.api.nvim_get_hl(0, {})
-- for name, hl_def in pairs(all_highlights) do
-- 	vim.notify(name)
-- end
--
-- for v, e in pairs(dap.listeners.after.event_stopped) do
-- 	vim.notify(v)
-- end
--
-- require("snacks")
-- Snacks.picker.lsp_symbols()
-- LazyVim.format.info(vim.api.nvim_get_current_buf())

-- Example of using vim.ui.input for prompting user input
-- local function ask_user_for_filename()
-- 	vim.ui.input({
-- 		prompt = "Enter a filename: ",
-- 		default = "new_file.txt",
-- 		completion = "file",
-- 	}, function(input)
-- 		if input then
-- 			-- User provided a filename
-- 			vim.cmd("edit " .. input)
-- 			print("Opening file: " .. input)
-- 		else
-- 			-- User cancelled the input
-- 			print("File creation cancelled")
-- 		end
-- 	end)
-- end
--
-- -- Call the function
-- ask_user_for_filename()
