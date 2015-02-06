
--[[--------------------------------------------------------
	-- Dragoon Framework - A Framework for Lua --
	-- Copyright (c) 2014-2015 TsT worldmaster.fr --
--]]--------------------------------------------------------

-- Lua 5.2 have the ./?/init.lua in his path, but not Lua 5.1.
-- This module fix the problem by adding "./?/init.lua" after "./?.lua" if found

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
	-- check if the lua path separator character is still the same.
	if package.config:sub(3,3) ~= ";" then
		error("the lua path separator should be a ';'. Please fix the pathfix.lua script nefore using it.", 2)
	end
	package.path = fix(package.path)
end

return {
	fix = fix,
	install = install,
	autoinstall = true,
}
