-- Local fork of Yazi's bundled `fzf` plugin.
--
-- Built-in preset plugins (like `fzf`) are hardcoded into Yazi's loader cache
-- at startup, so a same-named folder under ~/.config/yazi/plugins can never
-- override them -- the preset always wins before disk is ever consulted.
-- Hence this lives under a different name and is wired up in keymap.toml
-- instead of shadowing `fzf` directly.
--
-- Changes from upstream:
-- - Candidates come from `fd` (files + dirs, respects .gitignore by default)
--   instead of fzf's own built-in walker, which never lists directories and
--   has no concept of .gitignore at all.
-- - Alt-I reloads with `--no-ignore` (show gitignored files too), Alt-R
--   reloads back to the default (respect .gitignore again).
-- - Pass "dir" as the plugin arg (`plugin fzf-dir -- dir`) to only search
--   directories; the gitignore toggle behaves the same in that mode.
-- FZF_DEFAULT_COMMAND is set via :env() on this one spawned process only --
-- no global fzf config is touched.

local M = {}

local state = ya.sync(function()
	local selected = {}
	for _, f in pairs(cx.active.selected) do
		selected[#selected + 1] = f.url
	end
	return cx.active.current.cwd, selected
end)

function M:entry(job)
	ya.emit("escape", { visual = true })

	local cwd, selected = state()
	if not cwd.spec.is_regular then
		return ya.notify { title = "Fzf", content = "Only supported for regular paths", timeout = 5, level = "warn" }
	end

	local dirs_only = job.args[1] == "dir"

	local permit = ui.hide()
	local output, err = M.run_with(cwd, selected, dirs_only)

	permit:drop()
	if not output then
		return ya.notify { title = "Fzf", content = tostring(err), timeout = 5, level = "error" }
	end

	local urls = M.split_urls(cwd, output)
	if #urls == 0 then
		return
	elseif #urls == 1 then
		local cha = #selected == 0 and fs.cha(urls[1])
		return ya.emit(cha and cha.is_dir and "cd" or "reveal", { urls[1], raw = true })
	end

	local files = {}
	for _, url in ipairs(urls) do
		files[#files + 1] = fs.file(url)
	end
	if #files > 0 then
		files.state = #selected > 0 and "off" or "on"
		ya.emit("toggle_all", files)
	end
end

---@param cwd Url
---@param selected Url[]
---@param dirs_only boolean
---@return string?, Error?
function M.run_with(cwd, selected, dirs_only)
	local fd_cmd = dirs_only and "fd --type d --hidden --follow" or "fd --type f --type d --hidden --follow"
	local child, err = Command("fzf")
		:arg("-m")
		:env("FZF_DEFAULT_COMMAND", fd_cmd)
		:arg("--header=alt-[r]eset  .g[i]tignore: on")
		:arg("--bind=alt-i:reload(" .. fd_cmd .. " --no-ignore)+change-header(alt-[r]eset  .g[i]tignore: off)")
		:arg("--bind=alt-r:reload(" .. fd_cmd .. ")+change-header(alt-[r]eset  .g[i]tignore: on)")
		:cwd(tostring(cwd))
		:stdin(#selected > 0 and Command.PIPED or Command.INHERIT)
		:stdout(Command.PIPED)
		:spawn()

	if not child then
		return nil, Err("Failed to start `fzf`, error: %s", err)
	end

	for _, u in ipairs(selected) do
		child:write_all(string.format("%s\n", u))
	end
	if #selected > 0 then
		child:flush()
	end

	local output, err = child:wait_with_output()
	if not output then
		return nil, Err("Cannot read `fzf` output, error: %s", err)
	elseif not output.status.success and output.status.code ~= 130 then
		return nil, Err("`fzf` exited with error code %s", output.status.code)
	end
	return output.stdout, nil
end

function M.split_urls(cwd, output)
	local t = {}
	for line in output:gmatch("[^\r\n]+") do
		local u = Url(line)
		t[#t + 1] = u.is_absolute and u or cwd:resolve(u)
	end
	return t
end

return M
