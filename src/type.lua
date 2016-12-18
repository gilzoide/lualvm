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

--- @submodule type
-- LLVMType methods

local ll = require 'lualvm.llvm'

local Type = ll.LLVMType
Type.GetKind = ll.GetTypeKind
Type.IsSized = ll.TypeIsSized
Type.GetContext = ll.GetTypeContext
Type.Dump = ll.DumpType
Type.__tostring = ll.PrintTypeToString

--- Get the type length, which depends on the type kind
--
-- + Integer: int bit width
-- + Function: number of parameter types
-- + Struct: number of elements
-- 
-- If type isn't of those kinds, return nil
function Type:__len ()
	local kind = self:GetKind ()
	if kind == ll.IntegerTypeKind then
		return ll.GetIntTypeWidth (self)
	elseif kind == ll.FunctionTypeKind then
		return ll.CountParamTypes (self)
	elseif kind == ll.StructTypeKind then
		return ll.CountStructElementTypes (self)
	elseif kind == ll.ArrayTypeKind then
		return ll.GetArrayLength (self)
	elseif kind == ll.VectorKind then
		return ll.GetVectorSize (self)
	end
end

-- Function types methods
Type.IsFunctionVarArg = ll.IsFunctionVarArg
Type.GetReturnType = ll.GetReturnType
Type.GetParamTypes = ll.GetParamTypes
-- Structure types methods
Type.GetStructName = ll.GetStructName
Type.StructSetBody = ll.StructSetBody
Type.GetStructElementTypes = ll.GetStructElementTypes
Type.StructGetTypeAtIndex = ll.StructGetTypeAtIndex
Type.IsPackedStruct = ll.IsPackedStruct
Type.IsOpaqueStruct = ll.IsOpaqueStruct
-- Sequential types methods
Type.GetElementType = ll.GetElementType
Type.GetPointerAddressSpace = ll.GetPointerAddressSpace
