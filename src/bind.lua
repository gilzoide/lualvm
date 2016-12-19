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

--- @module bind
-- Facility to bind LLVM functions as methods for some metatable

local ll = require 'lualvm.llvm'

local bind = {}

--- Copy function `func_name` to `meta`, optionaly named `new_name`.
--
-- This function asserts `func_name` exists in LLVM
function bind.__call (_, meta, func_name, new_name)
	meta[new_name or func_name] = assert (ll[func_name], string.format (
			"[lualvm.bind] Couldn't find '%s' function in LLVM bindings", func_name))
end

--- Create an iterator function in `meta` named `new_name`, yielding values
-- starting from `ll.GetFirst"property" (obj)` until there's none left.
function bind.iterator (meta, new_name, property)
	meta[new_name] = function (self)
		return coroutine.wrap (function (obj)
			local first_func = ll['GetFirst' .. property]
			local next_func = ll['GetNext' .. property]
			local it = first_func (obj)
			repeat
				coroutine.yield (it)
				it = next_func (it)
			until not it
		end), self
	end
end

--- Create an iterator function in `meta` named `new_name`, with possible
-- reversing the results
function bind.iterator_with_reverse (meta, new_name, property)
	meta[new_name] = function (self, reversed)
		return coroutine.wrap (function (obj)
			local first_func = reversed and ll['GetLast' .. property] or ll['GetFirst' .. property]
			local next_func = reversed and ll['GetPrevious' .. property] or ll['GetNext' .. property]
			local it = first_func (obj)
			repeat
				coroutine.yield (it)
				it = next_func (it)
			until not it
		end), self
	end
end


return setmetatable (bind, bind)
