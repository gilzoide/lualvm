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

--- @submodule Builder
-- LLVMBuilder methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local Builder = ll.LLVMBuilder
bind (Builder, 'CreateBuilder', 'Create')
bind (Builder, 'PositionBuilder', 'Position')
bind (Builder, 'PositionBuilderBefore', 'PositionBefore')
bind (Builder, 'PositionBuilderAtEnd', 'PositionAtEnd')
bind (Builder, 'GetInsertBlock')
bind (Builder, 'ClearInsertionPosition')
--- Insert instruction into Builder, with optional name
function Builder:Insert (instr, name)
	return name and ll.InsertIntoBuilderWithName (self, instr, name) or ll.InsertIntoBuilder (self, instr)
end
bind (Builder, 'DisposeBuilder', 'Dispose')
bind (Builder, 'SetCurrentDebugLocation')
bind (Builder, 'GetCurrentDebugLocation')
bind (Builder, 'SetInstDebugLocation')
bind (Builder, 'BuildRetVoid', 'RetVoid')
bind (Builder, 'BuildRet', 'Ret')
bind (Builder, 'BuildAggregateRet', 'AggregateRet')
bind (Builder, 'BuildBr', 'Br') -- hu3hu3hu3hu3hu3
bind (Builder, 'BuildCondBr', 'CondBr')
bind (Builder, 'BuildSwitch', 'Switch')
bind (Builder, 'BuildIndirectBr', 'IndirectBr')
bind (Builder, 'BuildInvoke', 'Invoke')
bind (Builder, 'BuildLandingPad', 'LandingPad')
bind (Builder, 'BuildResume', 'Resume')
bind (Builder, 'BuildUnreachable', 'Unreachable')
bind (Builder, 'BuildAdd', 'Add')
bind (Builder, 'BuildNSWAdd', 'NSWAdd')
bind (Builder, 'BuildNUWAdd', 'NUWAdd')
bind (Builder, 'BuildFAdd', 'FAdd')
bind (Builder, 'BuildSub', 'Sub')
bind (Builder, 'BuildNSWSub', 'NSWSub')
bind (Builder, 'BuildNUWSub', 'NUWSub')
bind (Builder, 'BuildFSub', 'FSub')
bind (Builder, 'BuildMul', 'Mul')
bind (Builder, 'BuildNSWMul', 'NSWMul')
bind (Builder, 'BuildNUWMul', 'NUWMul')
bind (Builder, 'BuildFMul', 'FMul')
bind (Builder, 'BuildUDiv', 'UDiv')
bind (Builder, 'BuildSDiv', 'SDiv')
bind (Builder, 'BuildExactSDiv', 'ExactSDiv')
bind (Builder, 'BuildFDiv', 'FDiv')
bind (Builder, 'BuildURem', 'URem')
bind (Builder, 'BuildSRem', 'SRem')
bind (Builder, 'BuildFRem', 'FRem')
bind (Builder, 'BuildShl', 'Shl')
bind (Builder, 'BuildLShr', 'LShr')
bind (Builder, 'BuildAShr', 'AShr')
bind (Builder, 'BuildAnd', 'And')
bind (Builder, 'BuildOr', 'Or')
bind (Builder, 'BuildXor', 'Xor')
bind (Builder, 'BuildBinOp', 'BinOp')
bind (Builder, 'BuildNeg', 'Neg')
bind (Builder, 'BuildNSWNeg', 'NSWNeg')
bind (Builder, 'BuildNUWNeg', 'NUWNeg')
bind (Builder, 'BuildFNeg', 'FNeg')
bind (Builder, 'BuildNot', 'Not')
bind (Builder, 'BuildMalloc', 'Malloc')
bind (Builder, 'BuildArrayMalloc', 'ArrayMalloc')
bind (Builder, 'BuildAlloca', 'Alloca')
bind (Builder, 'BuildArrayAlloca', 'ArrayAlloca')
bind (Builder, 'BuildFree', 'Free')
bind (Builder, 'BuildLoad', 'Load')
bind (Builder, 'BuildStore', 'Store')
bind (Builder, 'BuildGEP', 'GEP')
bind (Builder, 'BuildInBoundsGEP', 'InBoundsGEP')
bind (Builder, 'BuildStructGEP', 'StructGEP')
bind (Builder, 'BuildGlobalString', 'GlobalString')
bind (Builder, 'BuildGlobalStringPtr', 'GlobalStringPtr')
bind (Builder, 'BuildTrunc', 'Trunc')
bind (Builder, 'BuildZExt', 'ZExt')
bind (Builder, 'BuildSExt', 'SExt')
bind (Builder, 'BuildFPToUI', 'FPToUI')
bind (Builder, 'BuildFPToSI', 'FPToSI')
bind (Builder, 'BuildUIToFP', 'UIToFP')
bind (Builder, 'BuildSIToFP', 'SIToFP')
bind (Builder, 'BuildFPTrunc', 'FPTrunc')
bind (Builder, 'BuildFPExt', 'FPExt')
bind (Builder, 'BuildPtrToInt', 'PtrToInt')
bind (Builder, 'BuildIntToPtr', 'IntToPtr')
bind (Builder, 'BuildBitCast', 'BitCast')
bind (Builder, 'BuildAddrSpaceCast', 'AddrSpaceCast')
bind (Builder, 'BuildZExtOrBitCast', 'ZExtOrBitCast')
bind (Builder, 'BuildSExtOrBitCast', 'SExtOrBitCast')
bind (Builder, 'BuildTruncOrBitCast', 'TruncOrBitCast')
bind (Builder, 'BuildCast', 'Cast')
bind (Builder, 'BuildPointerCast', 'PointerCast')
bind (Builder, 'BuildIntCast', 'IntCast')
bind (Builder, 'BuildFPCast', 'FPCast')
bind (Builder, 'BuildICmp', 'ICmp')
bind (Builder, 'BuildFCmp', 'FCmp')
bind (Builder, 'BuildPhi', 'Phi')
bind (Builder, 'BuildCall', 'Call')
bind (Builder, 'BuildSelect', 'Select')
bind (Builder, 'BuildVAArg', 'VAArg')
bind (Builder, 'BuildExtractElement', 'ExtractElement')
bind (Builder, 'BuildInsertElement', 'InsertElement')
bind (Builder, 'BuildShuffleVector', 'ShuffleVector')
bind (Builder, 'BuildExtractValue', 'ExtractValue')
bind (Builder, 'BuildInsertValue', 'InsertValue')
bind (Builder, 'BuildIsNull', 'IsNull')
bind (Builder, 'BuildIsNotNull', 'IsNotNull')
bind (Builder, 'BuildPtrDiff', 'PtrDiff')
bind (Builder, 'BuildFence', 'Fence')
bind (Builder, 'BuildAtomicRMW', 'AtomicRMW')
