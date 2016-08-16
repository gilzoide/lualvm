/* lualvm, a Lua wrapper for the LLVM-C API
 * Copyright (C) 2016 gilzoide
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Any bugs should be reported to <gilzoide@gmail.com>
 */

/** @file core/type.hpp
 * LLVMType bindings, for internal lualvm use only
 */
#pragma once

/// Lua LLVMType metatable
#define TYPE_METATABLE "LLVMType"

/** Get a LLVMTypeRef from Lua stack    [-0, +0, e]
 *
 * @param L Lua state
 * @param i Index of udata
 *
 * @return LLVM Type
 *
 * @throw If value is not a LLVMType
 */
#define checkType(L, i) \
	lualvm_check<LLVMTypeRef> (L, i, TYPE_METATABLE)

/** Push a LLVMTypeRef into the Lua stack (as light userdata)   [-0, +1, -]
 *
 * @param L Lua state
 * @param ty LLVM Type to be pushed
 */
#define pushType(L, ty) \
	lualvm_push<LLVMTypeRef> (L, ty, TYPE_METATABLE)

extern "C" {
	/// Open core.type
	int luaopen_lualvm_core_type (lua_State *L);
}
