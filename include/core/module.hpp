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

/** @file core/module.hpp
 * LLVMModule bindings, for internal lualvm use only
 */
#pragma once

#include "core.hpp"

/// Lua LLVMModule metatable
#define MODULE_METATABLE "LLVMModule"

/** Get a LLVMModuleRef from Lua stack    [-0, +0, e]
 *
 * @param L Lua state
 * @param i Index of udata
 *
 * @return LLVM Module
 *
 * @throw If value is not a LLVMModule
 */
#define checkModule(L, i) \
	lualvm_check<LLVMModuleRef> (L, i, MODULE_METATABLE)

/** Push a LLVMModuleRef into the Lua stack (as light userdata)   [-0, +1, -]
 *
 * @param L Lua state
 * @param mod LLVM Module to be pushed
 */
#define pushModule(L, mod) \
	lualvm_push<LLVMModuleRef> (L, mod, MODULE_METATABLE)

/**
 * Push a managed Module to Lua, so that it is garbage collected
 * 
 * Use only when creating new Modules
 */
#define pushManagedModule(L, mod) \
	lualvm_pushManaged<LLVMModuleRef> (L, mod, MODULE_METATABLE)
	

extern "C" {
	/// Open core.module module (echo?)
	int luaopen_lualvm_core_module (lua_State *L);
}
