--[[--------------------------------------------------------
	-- Dragoon Framework - A Framework for Lua/LOVE --
	-- Copyright (c) 2014-2015 TsT worldmaster.fr --
--]]--------------------------------------------------------

local error = error
local assert = assert
local package_loaded
local package_preload

-- provide("mymodule", "moduletoload", "force")

-- if 'm1' already loaded do nothing
-- provide("m1", require("m2"))
-- provide("m1", require("m2"), false)
-- provide("m1", require("m2"), not "force")
-- provide("m1", "m2")
-- provide("m1", "m2", false)
-- provide("m1", "m2", not "force")

-- if 'm1' already loaded, replace it by 'm2'
-- provide("m1", require("m2"), true)
-- provide("m1", require("m2"), "force")
-- provide("m1", "m2", true)
-- provide("m1", "m2", "force")

local function provide(modname, mod, force)
	if not(type(modname) == "string") then
		error("the module name must be a string : "..type(modname), 2)
	end
	if not (type(mod) == "table" or type(mod) == "string") then -- may I support function or userdata ?
		error("the supply module must be a table or string: "..type(mod), 2)
	end
	if modname == mod then
		return false, "ask to provide exactly what we want!"
	end

	local current = package_loaded[modname]
	if current == mod then -- nothing to change
		return true
	end

	if current and current ~= true then
		if not force then
			return false
		end
	end

	if type(mod) == "string" then
--		print("[provide] for "..modname.." try to require("..mod..")")
		mod = require(mod) -- catch error  and return to level 2 ?
		--if not(type(mod) == "table") then
		--	error("module is not a table after load : "..tostring(mod), 2)
		--end
	end

	package_loaded[modname] = mod
	return true
end

--
local function rawpreload(modname, modfunc, force)
	if not (type(modname) == "string") then
		error("the module name must be a string : "..type(modname), 2)
	end
	if not (type(modfunc) == "function" or type(modfunc) == "table" and modfunc.modname == modname) then
		error("the supply module must be a function : "..type(modfunc), 2)
	end

	local current = package_preload[modname]
	if current == modfunc then -- nothing to change
		return true
	end

	-- FIXME: a way to get back the aliased name ? callable table ?
	if current and current ~= true then
		if not force then 
			return false
		end
	end

	package_preload[modname] = modfunc
	return true
end

local function preload(modname, modfunc, force)
	if (type(modfunc) == "string") then
		modfunc = function() return require(modname) end -- FIXME: a way to get back the aliased name ? callable table ?
		--[[
		modfunc = setmetatable({modname = modname,}, {
			__call = function() return require(modname) end,
		})
		]]--
	end
	return rawpreload(modname, modfunc, force)
end


local function init()
	local package = require("package")
	package_loaded = package.loaded
	package_preload = package.preload
end
init()

local _M = {
	refresh = init,
	provide = provide,
	preload = preload, -- fail if you try to a require() inside
}

return setmetatable(_M, {
	__call = function(self, ...) return provide(...) end,
})
