-- Transient snapshots for yazi.nvim. No files or persistent DDS (@) messages.
local function equal(a, b)
	if type(a) ~= type(b) then
		return false
	elseif type(a) ~= "table" then
		return a == b
	end
	for k, v in pairs(a) do
		if not equal(v, b[k]) then
			return false
		end
	end
	for k in pairs(b) do
		if a[k] == nil then
			return false
		end
	end
	return true
end

local function publish(state)
	if not state.token or state.restoring then
		return
	end
	local snapshot = { active = cx.tabs.idx, tabs = {} }
	for _, tab in ipairs(cx.tabs) do
		local pref, current = tab.pref, tab.current
		snapshot.tabs[#snapshot.tabs + 1] = {
			cwd = tostring(current.cwd),
			hovered = current.hovered and tostring(current.hovered.url) or nil,
			name = pref.name,
			sort = {
				by = pref.sort_by,
				sensitive = pref.sort_sensitive,
				reverse = pref.sort_reverse,
				dir_first = pref.sort_dir_first,
				translit = pref.sort_translit,
			},
			linemode = pref.linemode,
			hidden = pref.show_hidden,
		}
	end
	if not equal(snapshot, state.previous) then
		state.previous = snapshot
		ps.pub_to(0, "nvim-session", { token = state.token, snapshot = snapshot })
	end
end

local attach = ya.sync(function(state, token)
	state.token, state.restoring, state.previous = token, true, nil
	if not state.installed then
		state.installed = true
		-- Native runtime bindings: included in the usual g-prefix popup and help.
		-- Installed only in processes attached to Neovim; nothing is written to disk.
		for _, binding in ipairs({
			{ on = { "g", "=" }, action = "cwd", desc = "Go to Neovim cwd" },
			{ on = { "g", "r" }, action = "fyler", desc = "Reveal in Fyler (stay)" },
			{ on = { "g", "R" }, action = "root", desc = "Go to LazyVim root of hovered file" },
			{ on = "-", action = "oil", desc = "Open cwd in Oil" },
			{ on = "Y", action = "copy_path", desc = "Copy path picker" },
		}) do
			km.mgr.rules:insert(1, {
				on = binding.on,
				run = "plugin nvim-session 'action " .. binding.action .. "'",
				desc = binding.desc,
			})
		end
		-- Snapshot after redraw, including changes to inactive tabs and preferences.
		Status:children_add(function()
			publish(state)
			return ""
		end, 9999, Status.RIGHT)
	end
end)

local finish = ya.sync(function(state)
	state.restoring = false
	publish(state)
end)

local dispatch = ya.sync(function(state, action)
	if not state.token then
		return
	end
	publish(state)
	local current = cx.active.current
	ps.pub_to(0, "nvim-session", {
		token = state.token,
		action = action,
		path = tostring(current.hovered and current.hovered.url or current.cwd),
	})
end)

local function apply(tab)
	ya.exec("sort", tab.sort)
	ya.exec("linemode", { tab.linemode })
	ya.exec("hidden", { tab.hidden and "show" or "hide" })
	if tab.name and tab.name ~= "" then
		ya.exec("tab_rename", { tab.name })
	end
	if tab.hovered then
		-- cwd is already the saved parent, so a hovered directory is not entered.
		ya.exec("reveal", { tab.hovered })
	end
end

return {
	entry = function(_, job)
		if job.args[1] == "action" then
			local action = job.args[2]
			if action == "cwd" or action == "root" or action == "fyler" or action == "oil" or action == "copy_path" then
				dispatch(action)
			end
			return
		end
		local request = ya.json_decode(job.args[1])
		if not request or not request.token then
			return
		end
		attach(request.token)
		local session = request.snapshot
		if session and #session.tabs > 0 then
			-- Neovim starts this process in the saved active directory.
			local active = session.active
			apply(session.tabs[active])
			-- Insert preceding tabs ahead of the original tab, preserving their order.
			for i = active - 1, 1, -1 do
				ya.exec("tab_create", { session.tabs[i].cwd })
				apply(session.tabs[i])
				ya.exec("tab_swap", { -1 })
			end
			ya.exec("tab_switch", { active - 1 })
			for i = active + 1, #session.tabs do
				ya.exec("tab_create", { session.tabs[i].cwd })
				apply(session.tabs[i])
			end
			ya.exec("tab_switch", { active - 1 })
		end
		finish()
	end,
}
