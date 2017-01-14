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

--- @submodule ObjectFile
-- LLVMObjectFile methods

local ll = require 'lualvm.llvm'
local bind = require 'lualvm.bind'

local ObjectFile = ll.LLVMObjectFile
bind (ObjectFile, 'CreateObjectFile', 'Create')
bind (ObjectFile, 'DisposeObjectFile', 'Dispose')
bind (ObjectFile, 'GetSections')
bind (ObjectFile, 'IsSectionIteratorAtEnd')
bind (ObjectFile, 'GetSymbols')
bind (ObjectFile, 'IsSymbolIteratorAtEnd')
bind.object_file_iterator (ObjectFile, 'Sections', 'Section')
bind.object_file_iterator (ObjectFile, 'Symbols', 'Symbol')

local SectionIterator = ll.LLVMSectionIterator
bind (SectionIterator, 'DisposeSectionIterator', 'Dispose')
bind (SectionIterator, 'MoveToNextSection')
bind (SectionIterator, 'MoveToContainingSection')
bind (SectionIterator, 'GetSectionName', 'GetName')
bind (SectionIterator, 'GetSectionSize', 'GetSize')
bind (SectionIterator, 'GetSectionContents', 'GetContents')
bind (SectionIterator, 'GetSectionAddress', 'GetAddress')
bind (SectionIterator, 'GetSectionContainsSymbol', 'ContainsSymbol')
bind (SectionIterator, 'GetRelocations')
bind (SectionIterator, 'IsRelocationIteratorAtEnd')
bind.object_file_iterator (SectionIterator, 'Relocations', 'Relocation')

local SymbolIterator = ll.LLVMSymbolIterator
bind (SymbolIterator, 'DisposeSymbolIterator', 'Dispose')
bind (SymbolIterator, 'MoveToNextSymbol')
bind (SymbolIterator, 'GetSymbolName', 'GetName')
bind (SymbolIterator, 'GetSymbolSize', 'GetSize')
bind (SymbolIterator, 'GetSymbolAddress', 'GetAddress')

local RelocationIterator = ll.LLVMRelocationIterator
bind (RelocationIterator, 'DisposeRelocationIterator', 'Dispose')
bind (RelocationIterator, 'MoveToNextRelocation')
bind (RelocationIterator, 'GetRelocationOffset', 'GetOffset')
bind (RelocationIterator, 'GetRelocationSymbol', 'GetSymbol')
bind (RelocationIterator, 'GetRelocationType', 'GetType')
bind (RelocationIterator, 'GetRelocationTypeName', 'GetTypeName')
bind (RelocationIterator, 'GetRelocationValueString', 'GetValueString')
