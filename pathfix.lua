
local function fix(path)
	local p2 = ";" .. path .. ";"
	if not p2:find(";./?/init.lua;", nil, true) then
		local b, e = p2:find(";./?.lua;", nil, "plain")
		return p2:sub(2, e) .. "./?/init.lua" .. p2:sub(e, -2)
	end
	return path
end
local function install()
	local package = require("package")
	package.path = fix(package.path)
end

return {
	fix = fix,
	install = install,
	autoinstall = true,
}
