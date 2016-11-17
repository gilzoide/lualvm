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

--- @module lualvm
-- LuaLVM module, with bindings for LLVM stuff

-- Start off with Core
local llvm = require 'lualvm.core'

--- Wrapper for LLVMGetMDKindIDInContext, supplying string length automaticaly
function llvm.GetMDKindIDInContext (C, Name)
	return llvm._GetMDKindIDInContext (C, Name, #Name)
end

--- Wrapper for LLVMGetMDKindID, supplying string length automaticaly
function llvm.GetMDKindID (Name)
	return llvm._GetMDKindID (Name, #Name)
end

--- Wrapper for LLVMGetNamedMetadataOperands, with 'Lua table -> C array' conversion
function llvm.GetNamedMetadataOperands (M, name)
    local numOperands = llvm.GetNamedMetadataNumOperands (M, name)
    local ret = {}
    -- avoid unnecessary operations if 'numOperands == 0'
    if numOperands > 0 then
        local arr = llvm.new_LLVMValueRef (numOperands)
        llvm._GetNamedMetadataOperands (M, name, arr)
        for i = 0, numOperands - 1 do
            table.insert (ret, llvm.LLVMValueRef_getitem (arr, i))
        end
        llvm.delete_LLVMValueRef (arr)
    end
    return ret
end

return llvm
