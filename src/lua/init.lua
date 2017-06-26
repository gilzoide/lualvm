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

--- @module lualvm
-- LuaLVM module, with bindings for LLVM stuff

-- Start off with pure C bindings
local llvm = require 'lualvm.llvm'

-- and change the needed struct metatables
require 'lualvm.Context'
require 'lualvm.Module'
require 'lualvm.Type'
require 'lualvm.Value'
require 'lualvm.BasicBlock'
require 'lualvm.Builder'
require 'lualvm.MemoryBuffer'
require 'lualvm.ExecutionEngine'
require 'lualvm.TargetData'
require 'lualvm.TargetMachine'
require 'lualvm.PassManager'
require 'lualvm.ObjectFile'

--- Lualvm version string
llvm.VERSION = '1.0.0'

return llvm
