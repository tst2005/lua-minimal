--[[--------------------------------------------------------
	-- Dragoon Framework - A Framework for Lua --
	-- Copyright (c) 2014-2015 TsT worldmaster.fr --
--]]--------------------------------------------------------

local calledpath = (... or "")
local path = (calledpath):gsub("%.init$", "") -- /!\  DO NOT USE "newmodule" here,
path = path ~= "" and path.."." or ""        --      it is NOT AVAILABLE at this step.

-- Load newmodule
--  Direct load, no "newmodule" or "newmodule.init" at this step :
local newmodule = require(path .. "newmodule.newmodule")

-- Load provide
--  Direct load, no "provid
local provide_modname = path .. "provide.provide"
local provide = require(provide_modname)
-- Warning: provide.provide can not use "newmodule"
--          it's not a strict "newmodule" format

if not provide._NAME and not provide._PATH then
	local providefixed = newmodule:from(provide, provide_modname)
	assert(providefixed._NAME and providefixed._PATH)
	assert(provide == providefixed)
	providefixed(provide_modname, provide, "overwrite")
end

-- Setup provide
provide("provide", provide, not "forced")

-- Setup newmodule
provide("newmodule", newmodule, not "forced")

-- Creaqte the module itself : usefull to check if the framework is initialised.
local _M = newmodule(...)

-- Should with Fix the path in minimal ? => No
--	require(path .. "pathfix").install()

-- Called directly with *.minimal.init ? provide the *.minimal
if calledpath:find("%.init$") then
	provide(calledpath:gsub("%.init$",""), _M)
end

do -- self test
	local a = require("provide")
	local b = require("newmodule")
end

_M.provide = provide
_M.newmodule = newmodule

return _M

-- This module is mandatory to bootstrap the framework
-- Usualy called in lua code by :
--   require("dragoon-framework.lua.minimal.init")
-- or via Lua command line interpretor
--   $ lua -l dragoon-framework.lua.minimal.init

