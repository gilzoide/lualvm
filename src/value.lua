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

--- @submodule value
-- LLVMValue methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local Value = ll.LLVMValue
bind (Value, 'TypeOf')
bind (Value, 'GetValueName', 'GetName')
bind (Value, 'SetValueName', 'SetName')
bind (Value, 'DumpValue', 'Dump')
bind (Value, 'PrintValueToString', '__tostring')
bind (Value, 'ReplaceAllUsesWith')
bind (Value, 'IsConstant')
bind (Value, 'IsUndef')
bind (Value, 'IsAMDNode')
bind (Value, 'IsAMDString')
bind (Value, 'GetFirstUse')

local Use = ll.LLVMUse
bind (Use, 'GetNextUse')
bind (Use, 'GetUser')
bind (Use, 'GetUsedValue')

--- Iterate over LLVMValue's Uses
--
-- @return Value uses iterator
bind.iterator (Value, 'Uses', 'Use')

bind (Value, 'GetOperand')
bind (Value, 'GetOperandUse')
bind (Value, 'SetOperand')

-- Constants
bind (Value, 'IsNull')
bind (Value, 'GetConstOpcode')
bind (Value, 'GetGlobalParent')
bind (Value, 'IsDeclaration')
bind (Value, 'GetLinkage')
bind (Value, 'SetLinkage')
bind (Value, 'GetSection')
bind (Value, 'SetSection')
bind (Value, 'GetVisibility')
bind (Value, 'SetVisibility')
bind (Value, 'GetDLLStorageClass')
bind (Value, 'SetDLLStorageClass')
bind (Value, 'HasUnnamedAddr')
bind (Value, 'SetUnnamedAddr')
bind (Value, 'GetAlignment')
bind (Value, 'SetAlignment')

-- Global Variables
bind (Value, 'GetNextGlobal')
bind (Value, 'GetPreviousGlobal')
bind (Value, 'GetInitializer')
bind (Value, 'SetInitializer')
bind (Value, 'IsThreadLocal')
bind (Value, 'SetThreadLocal')
bind (Value, 'IsGlobalConstant')
bind (Value, 'SetGlobalConstant')
bind (Value, 'GetThreadLocalMode')
bind (Value, 'SetThreadLocalMode')
bind (Value, 'IsExternallyInitialized')
bind (Value, 'SetExternallyInitialized')

-- Constant Function Values
bind (Value, 'GetPersonalityFn')
bind (Value, 'SetPersonalityFn')
bind (Value, 'GetIntrinsicID')
bind (Value, 'GetFunctionCallConv')
bind (Value, 'SetFunctionCallConv')
bind (Value, 'GetGC')
bind (Value, 'SetGC')
bind (Value, 'AddFunctionAttr')
bind (Value, 'AddTargetDependentFunctionAttr')
bind (Value, 'GetFunctionAttr')
bind (Value, 'RemoveFunctionAttr')
-- Constant Function Values / Function Parameters
bind (Value, 'CountParams')
bind (Value, 'GetParams')
bind (Value, 'GetParam')
bind (Value, 'GetParamParent')
bind (Value, 'GetFirstParam')
bind (Value, 'GetLastParam')
bind (Value, 'GetNextParam')
bind (Value, 'GetPreviousParam')
bind (Value, 'AddAttribute')
bind (Value, 'RemoveAttribute')
bind (Value, 'GetAttribute')
bind (Value, 'SetParamAlignment')

--- Iterate over (LLVMValue) Function's Parameters
--
-- @param reversed Should the iteration be reversed?
--
-- @return Function parameters iterator
bind.iterator_with_reverse (Value, 'Params', 'Param')

-- Metadata
bind (Value, 'GetMDString')
bind (Value, 'GetMDNodeNumOperands')
bind (Value, 'GetMDNodeOperands')
