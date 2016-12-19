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

--- @submodule BasicBlock
-- LLVMBasicBlock methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local BasicBlock = ll.LLVMBasicBlock
bind (BasicBlock, 'BasicBlockAsValue', 'AsValue')
bind (BasicBlock, 'GetBasicBlockParent', 'GetParent')
bind (BasicBlock, 'GetBasicBlockTerminator', 'GetTerminator')
--- LLVMInsertBasicBlockInContext using Value as first argument
function BasicBlock:InsertInContext (ctx, name)
	return ll.InsertBasicBlockInContext (ctx, self, name)
end
bind (BasicBlock, 'InsertBasicBlock', 'Insert')
bind (BasicBlock, 'DeleteBasicBlock', 'Delete')
bind (BasicBlock, 'RemoveBasicBlockFromParent', 'RemoveFromParent')
bind (BasicBlock, 'MoveBasicBlockBefore', 'MoveBefore')
bind (BasicBlock, 'MoveBasicBlockAfter', 'MoveAfter')
bind (BasicBlock, 'GetFirstInstruction')
bind (BasicBlock, 'GetLastInstruction')
bind.iterator_with_reverse (BasicBlock, 'Instructions', 'Instruction')
