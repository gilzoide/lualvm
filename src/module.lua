--[[
-- Copyright 2016 Gil Barbosa Reis <gilzoide@gmail.com>
-- This file is part of Lualvm.
--
-- Lualvm is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- Lualvm is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with Lualvm.  If not, see <http://www.gnu.org/licenses/>.
--]]

--- @submodule context
-- LLVMModule methods

local ll = require 'lualvm.llvm'

local Module = ll.LLVMModule

--- Create a LLVMModule instance from name on the global context
function Module.Create (name)
	return ll.ModuleCreateWithName (name)
end

Module.Clone = ll.CloneModule
Module.Dispose = ll.DisposeModule
Module.GetDataLayout = ll.GetDataLayout
Module.SetDataLayout = ll.SetDataLayout
Module.GetTarget = ll.GetTarget
Module.SetTarget = ll.SetTarget
Module.Dump = ll.DumpModule
Module.PrintToFile = ll.PrintModuleToFile
Module.SetInlineAsm = ll.SetModuleInlineAsm
Module.GetContext = ll.GetModuleContext
Module.GetTypeByName = ll.GetTypeByName
Module.GetNamedMetadataOperands = ll.GetNamedMetadataOperands
Module.AddNamedMetadataOperand = ll.AddNamedMetadataOperand
Module.AddFunction = ll.AddFunction
Module.GetNamedFunction = ll.GetNamedFunction
Module.__tostring = ll.PrintModuleToString
Module.GetFirstFunction = ll.GetFirstFunction
Module.GetLastFunction = ll.GetLastFunction

local function function_iterator (mod)
	local it = mod:GetFirstFunction ()
	repeat
		coroutine.yield (it)
		it = ll.GetNextFunction (it)
	until not it
end
local function reverse_function_iterator (mod)
	local it = mod:GetLastFunction ()
	repeat
		coroutine.yield (it)
		it = ll.GetPreviousFunction (it)
	until not it
end
--- Iterate over LLVMModule's functions
--
-- @param reversed Should the iteration be reversed?
--
-- @return Function iterator
function Module:Functions (reversed)
	return coroutine.wrap (reversed and reverse_function_iterator or function_iterator)
			, self
end

