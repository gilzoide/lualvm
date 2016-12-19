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
local bind = require 'lualvm.bind'

local Type = ll.LLVMType
bind (Type, 'GetTypeKind', 'GetKind')
bind (Type, 'TypeIsSized', 'IsSized')
bind (Type, 'GetTypeContext', 'GetContext')
bind (Type, 'DumpType', 'Dump')
bind (Type, 'PrintTypeToString', '__tostring')

-- Integer types method
bind (Type, 'GetIntTypeWidth', 'GetIntWidth')
-- Function types methods
bind (Type, 'IsFunctionVarArg')
bind (Type, 'GetReturnType')
bind (Type, 'CountParamTypes')
bind (Type, 'GetParamTypes')
-- Structure types methods
bind (Type, 'GetStructName')
bind (Type, 'StructSetBody')
bind (Type, 'CountStructElementTypes')
bind (Type, 'GetStructElementTypes')
bind (Type, 'StructGetTypeAtIndex')
bind (Type, 'IsPackedStruct')
bind (Type, 'IsOpaqueStruct')
-- Sequential types methods
bind (Type, 'GetElementType')
bind (Type, 'GetArrayLength')
bind (Type, 'GetPointerAddressSpace')
bind (Type, 'GetVectorSize')

-- Value / Constants
bind (Type, 'AlignOf')
bind (Type, 'SizeOf')
bind (Type, 'ConstNull')
bind (Type, 'ConstAllOnes')
bind (Type, 'GetUndef')
bind (Type, 'ConstPointerNull')
