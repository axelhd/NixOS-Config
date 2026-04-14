return {
	entry = function()
		local selected = cx.active.selected
		if #selected == 0 then
			local h = cx.active.current.hovered
			if h then
				selected = { h.url }
			end
		end

		local cwd = tostring(cx.active.current.cwd)

		for _, url in ipairs(selected) do
			local src = tostring(url)
			local filename = src:match("([^/]+)$")
			local dest = cwd .. "/" .. filename

			if src ~= dest then
				os.execute(
					string.format(
						"/run/current-system/sw/bin/mv %q %q && /run/current-system/sw/bin/ln -s %q %q",
						src,
						dest,
						dest,
						src
					)
				)
			end
		end

		ya.mgr_emit("reload", {})
	end,
}
