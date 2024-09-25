local Popup = require("nui.popup")
local Layout = require("nui.layout")

local popup = Popup({
	position = "50%",
	size = {
		width = 80,
		height = 40,
	},
	enter = true,
	focusable = true,
	zindex = 50,
	relative = "editor",
	border = {
		padding = {
			top = 2,
			bottom = 2,
			left = 3,
			right = 3,
		},
		style = "single",
		text = {
			top = " I am top title ",
			top_align = "center",
			bottom = "I am bottom title",
			bottom_align = "left",
		},
	},
	buf_options = {
		modifiable = true,
		readonly = false,
	},
	win_options = {
		winblend = 0,
		winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
	},
})

popup:mount()
