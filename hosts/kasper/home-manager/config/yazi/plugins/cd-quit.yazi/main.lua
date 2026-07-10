--- @since 25.5.31

-- Enter on a directory: cd into it, then quit so the shell wrapper can follow
-- (yazi writes the final cwd to its --cwd-file on exit).
-- Enter on a file: open it as usual.
local hovered_is_dir = ya.sync(function()
	local h = cx.active.current.hovered
	return h ~= nil and h.cha.is_dir
end)

return {
	entry = function()
		if not hovered_is_dir() then
			ya.emit("open", { hovered = true })
			return
		end

		ya.emit("enter", {})
		ya.emit("quit", {})
	end,
}
