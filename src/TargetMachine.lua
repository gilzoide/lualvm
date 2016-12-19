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

--- @submodule TargetMachine
-- LLVMTarget and LLVMTargetMachine methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local Target = ll.LLVMTarget
bind.iterator (Target, 'Targets', 'Target')
bind (Target, 'GetTargetFromName', 'FromName')
--- Finds target corresponding to the given triple.
--
-- Returns nil + string on error
--
-- @return[0] Target
-- @return[1] nil
-- @return[1] error string
function Target.FromTriple (triple)
	return select (2, ll.GetTargetFromTriple (triple))
end

bind (Target, 'GetTargetName', 'GetName')
bind (Target, 'GetTargetDescription', 'GetDescription')
bind (Target, 'TargetHasJIT', 'HasJIT')
bind (Target, 'TargetHasTargetMachine', 'HasTargetMachine')
bind (Target, 'TargetHasAsmBackend', 'HasAsmBackend')
bind (Target, 'GetDefaultTargetTriple', 'GetDefaultTriple')


local TargetMachine = ll.LLVMTargetMachine
bind (TargetMachine, 'CreateTargetMachine', 'Create')
bind (TargetMachine, 'DisposeTargetMachine', 'Dispose')
bind (TargetMachine, 'GetTargetMachineTarget', 'GetTarget')
bind (TargetMachine, 'GetTargetMachineTriple', 'GetTriple')
bind (TargetMachine, 'GetTargetMachineCPU', 'GetCPU')
bind (TargetMachine, 'GetTargetMachineFeatureString', 'GetFeatureString')
bind (TargetMachine, 'CreateTargetDataLayout')
bind (TargetMachine, 'SetTargetMachineAsmVerbosity', 'SetAsmVerbosity')
bind (TargetMachine, 'TargetMachineEmitToFile', 'EmitToFile')
bind (TargetMachine, 'TargetMachineEmitToMemoryBuffer', 'EmitToMemoryBuffer')
