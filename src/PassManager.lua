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

--- @submodule PassManager
-- LLVMPassManager and LLVMPassManagerBuilder methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local PassManager = ll.LLVMPassManager
bind (PassManager, 'CreatePassManager', 'Create')
bind (PassManager, 'CreateFunctionPassManagerForModule', 'CreateForModule')
bind (PassManager, 'RunPassManager', 'Run')
bind (PassManager, 'InitializeFunctionPassManager')
bind (PassManager, 'RunFunctionPassManager')
bind (PassManager, 'FinalizeFunctionPassManager')
bind (PassManager, 'DisposePassManager', 'Dispose')

local PassManagerBuilder = ll.LLVMPassManagerBuilder
local PassManagerBuilderStringEnd = #'PassManagerBuilder' + 1
-- Transforms, PassManagerBuilder
for name, _ in pairs (ll) do
	if name:match '^Add.+Pass$' then
		bind (PassManager, name)
	elseif name:match '^PassManagerBuilder.+' then
		bind (PassManagerBuilder, name, name:sub (PassManagerBuilderStringEnd))
	end
end
