-- require("multinput").setup()
-- vim.ui.input({ prompt = "Enter value for shiftwidth: " }, function(input)
-- 	vim.o.shiftwidth = tonumber(input)
-- end)

-- Example of using vim.ui.input for prompting user input
local function ask_user_for_filename()
	vim.ui.input({
		prompt = "Enter a filename: ",
		default = "new_file.txt",
		completion = "file",
	}, function(input)
		if input then
			-- User provided a filename
			vim.cmd("edit " .. input)
			print("Opening file: " .. input)
		else
			-- User cancelled the input
			print("File creation cancelled")
		end
	end)
end

-- Call the function
ask_user_for_filename()
