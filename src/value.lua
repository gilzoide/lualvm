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

--- @submodule value
-- LLVMValue methods

local ll = require 'lualvm.llvm'

local Value = ll.LLVMValue
Value.TypeOf = ll.TypeOf
Value.GetName = ll.GetValueName
Value.SetName = ll.SetValueName
Value.Dump = ll.DumpValue
Value.__tostring = ll.PrintValueToString
Value.ReplaceAllUsesWith = ll.ReplaceAllUsesWith
Value.IsConstant = ll.IsConstant
Value.IsUndef = ll.IsUndef
Value.IsAMDNode = ll.IsAMDNode
Value.IsAMDString = ll.IsAMDString
Value.GetFirstUse = ll.GetFirstUse

local Use = ll.LLVMUse
Use.GetNextUse = ll.GetNextUse
Use.GetUser = ll.GetUser
Use.GetUsedValue = ll.GetUsedValue

local function use_iterator (val)
	local it = val:GetFirstUse ()
	repeat
		coroutine.yield (it:GetUser (), it:GetUsedValue ())
		it = it:GetNextUse ()
	until not it
end

--- Iterate over LLVMValue's Uses, yielding { User, UsedValue }
function Value:Uses ()
	return coroutine.wrap (use_iterator), self
end

Value.GetOperand = ll.GetOperand
Value.GetOperandUse = ll.GetOperandUse
Value.SetOperand = ll.SetOperand
-- TODO: terminar Values/Constants
