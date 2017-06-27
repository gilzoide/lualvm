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

--- @module bind
-- Facility to bind LLVM functions as methods for some metatable

local ll = require 'lualvm.llvm'

local bind = {}

--- Find `LLVMfunc_name`, raising warning if not found
local function find_on_llvm (func_name)
	local f = ll[func_name]
	if f == nil then
		io.stderr:write (string.format (
				"[lualvm.bind] WARNING: Couldn't find %q function in LLVM bindings\n",
				func_name))
	end
	return f
end
	

--- Copy function `func_name` to `meta`, optionaly named `new_name`.
--
-- This function asserts `func_name` exists in LLVM
function bind.__call (_, meta, func_name, new_name)
	meta[new_name or func_name] = find_on_llvm (func_name)
end

--- Create an iterator function in `meta` named `new_name`, yielding values
-- starting from `ll.GetFirst"property" (obj)` until there's none left.
function bind.iterator (meta, new_name, property)
	meta[new_name] = function (self)
		return coroutine.wrap (function (obj)
			local first_func = find_on_llvm ('GetFirst' .. property)
			local next_func = find_on_llvm ('GetNext' .. property)
			if first_func and next_func then
				local it = first_func (obj)
				repeat
					coroutine.yield (it)
					it = next_func (it)
				until not it
			end
		end), self
	end
end

--- Create an iterator function in `meta` named `new_name`, with possible
-- reversing the results
function bind.iterator_with_reverse (meta, new_name, property)
	meta[new_name] = function (self, reversed)
		return coroutine.wrap (function (obj)
			local first_func = reversed and find_on_llvm ('GetLast' .. property) or find_on_llvm ('GetFirst' .. property)
			local next_func = reversed and find_on_llvm ('GetPrevious' .. property) or find_on_llvm ('GetNext' .. property)
			if first_func and next_func then
				local it = first_func (obj)
				repeat
					coroutine.yield (it)
					it = next_func (it)
				until not it
			end
		end), self
	end
end

function bind.object_file_iterator (meta, new_name, property)
	meta[new_name] = function (self)
		return coroutine.wrap (function (obj)
			local get_iterator = find_on_llvm ('Get' .. property .. 's')
			local move_iterator = find_on_llvm ('MoveToNext' .. property)
			local check_end_func = find_on_llvm ('Is' .. property .. 'IteratorAtEnd')
			local dispose_func = find_on_llvm ('Dispose' .. property .. 'Iterator')
			if get_iterator and move_iterator and check_end_func and dispose_func then
				local it = get_iterator (obj)
				repeat
					coroutine.yield (it)
					move_iterator (it)
				until check_end_func (it)
				dispose_func (it)
			end
		end), self
	end
end


return setmetatable (bind, bind)
