function mount_point(path)
	local handle = io.popen("findmnt -n --output FSTYPE,SOURCE " .. ya.quote(path))
	local stdout = handle:read("*a")

	if handle:close() then
		local fstype, device = stdout:match("^(.*) (.*)$")
		local device_str = device:sub(1, 1) == "/" and " on " .. device or ""
		return string.format(" [%s%s]", fstype, device_str)
	end

	return ""
end

return {
	setup = function()
		Header.cwd = function(self, max)
			local cwd = tostring(cx.active.current.cwd)
			local mp = mount_point(cwd)

			local s = ya.readable_path(cwd) .. mp .. self:flags()
			return ui.Span(ya.truncate(s, { max = max, rtl = true })):style(THEME.manager.cwd)
		end

		File.full = function(self, file)
			return ya.flat({
				self:icon(file),
				self:prefix(file),
				self:highlights(file),
				self:found(file),
				self:symlink(file),
				{ ui.Span(mount_point(tostring(file.url))):style({ fg = "reset" }) },
			})
		end
	end,
}
