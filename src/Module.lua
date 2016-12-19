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

--- @submodule Module
-- LLVMModule methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local Module = ll.LLVMModule

bind (Module, 'ModuleCreateWithName', 'Create')
bind (Module, 'CloneModule', 'Clone')
bind (Module, 'DisposeModule', 'Dispose')
bind (Module, 'GetDataLayout')
bind (Module, 'SetDataLayout')
bind (Module, 'GetTarget')
bind (Module, 'SetTarget')
bind (Module, 'DumpModule', 'Dump')
bind (Module, 'PrintModuleToFile', 'PrintToFile')
bind (Module, 'SetModuleInlineAsm', 'SetInlineAsm')
bind (Module, 'GetModuleContext', 'GetContext')
bind (Module, 'GetTypeByName')
bind (Module, 'GetNamedMetadataOperands')
bind (Module, 'AddNamedMetadataOperand')
bind (Module, 'AddFunction')
bind (Module, 'GetNamedFunction')
bind (Module, 'PrintModuleToString', '__tostring')
bind (Module, 'GetFirstFunction')
bind (Module, 'GetLastFunction')

--- Iterate over LLVMModule's functions
--
-- @param reversed Should the iteration be reversed?
--
-- @return Function iterator
bind.iterator_with_reverse (Module, 'Functions', 'Function')

-- Constant Global Variables
bind (Module, 'AddGlobal')
bind (Module, 'AddGlobalInAddressSpace')
bind (Module, 'GetNamedGlobal', 'GetGlobal')
bind (Module, 'GetFirstGlobal')
bind (Module, 'GetLastGlobal')

--- Iterate over LLVMModule's global variables
--
-- @param reversed Should the iteration be reversed?
--
-- @return Global variables iterator
bind.iterator_with_reverse (Module, 'Globals', 'Global')

-- Constant Global Aliases
bind (Module, 'AddAlias')
