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

--- @submodule Context
-- LLVMContext methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local Context = ll.LLVMContext
bind (Context, 'ContextDispose', 'Dispose')
bind (Context, 'GetMDKindIDInContext', 'GetMDKindID')
bind (Context, 'ModuleCreateWithNameInContext', 'Module')

-- Types
bind (Context, 'Int1TypeInContext', 'Int1Type')
bind (Context, 'Int8TypeInContext', 'Int8Type')
bind (Context, 'Int16TypeInContext', 'Int16Type')
bind (Context, 'Int32TypeInContext', 'Int32Type')
bind (Context, 'Int64TypeInContext', 'Int64Type')
bind (Context, 'Int128TypeInContext', 'Int128Type')
bind (Context, 'IntTypeInContext', 'IntType')

bind (Context, 'HalfTypeInContext', 'HalfType')
bind (Context, 'FloatTypeInContext', 'FloatType')
bind (Context, 'DoubleTypeInContext', 'DoubleType')
bind (Context, 'X86FP80TypeInContext', 'X86FP80Type')
bind (Context, 'FP128TypeInContext', 'FP128Type')
bind (Context, 'PPCFP128TypeInContext', 'PPCFP128Type')

bind (Context, 'StructTypeInContext', 'StructType')
bind (Context, 'StructCreateNamed', 'NamedStruct')

bind (Context, 'VoidTypeInContext', 'VoidType')
bind (Context, 'LabelTypeInContext', 'LabelType')
bind (Context, 'X86MMXTypeInContext', 'X86MMXType')

-- Constants
bind (Context, 'ConstStringInContext', 'ConstString')
bind (Context, 'ConstStructInContext', 'ConstStruct')

-- Metadata
bind (Context, 'MDStringInContext', 'MDString')
bind (Context, 'MDNodeInContext', 'MDNode')

-- IRBuilder
bind (Context, 'CreateBuilderInContext', 'Builder')
