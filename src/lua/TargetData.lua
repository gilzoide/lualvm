--[[
-- Copyright 2016-2017 Gil Barbosa Reis <gilzoide@gmail.com>
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

--- @submodule TargetData
-- LLVMTargetData methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local TargetData = ll.LLVMTargetData

--- Creates a LLVMTargetData from target layout string
function TargetData.Create (target_layout)
	return ll.CreateTargetData (target_layout)
end

bind (TargetData, 'CopyStringRepOfTargetData', '__tostring')
bind (TargetData, 'ByteOrder')
bind (TargetData, 'PointerSize')
bind (TargetData, 'PointerSizeForAS')
bind (TargetData, 'IntPtrType')
bind (TargetData, 'IntPtrTypeForAS')

--- LLVMIntPtrTypeInContext using TargetData as first argument
function TargetData:IntPtrTypeInContext (ctx)
	return ll.IntPtrTypeInContext (ctx, self)
end
--- LLVMIntPtrTypeForASInContext using TargetData as first argument
function TargetData:IntPtrTypeForASInContext (ctx, as)
	return ll.IntPtrTypeForASInContext (ctx, self, as)
end

bind (TargetData, 'SizeOfTypeInBits')
bind (TargetData, 'StoreSizeOfType')
bind (TargetData, 'ABISizeOfType')
bind (TargetData, 'ABIAlignmentOfType')
bind (TargetData, 'CallFrameAlignmentOfType')
bind (TargetData, 'PreferredAlignmentOfType')
bind (TargetData, 'PreferredAlignmentOfGlobal')
bind (TargetData, 'ElementAtOffset')
bind (TargetData, 'OffsetOfElement')
bind (TargetData, 'DisposeTargetData', 'Dispose')
