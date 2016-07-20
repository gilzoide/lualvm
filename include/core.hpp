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

/** @file core.hpp
 * LLVMContext bindings, for internal lualvm use only
 */
#pragma once

#include "lualvm.hpp"

#include <llvm-c/Core.h>

//----    LLVMContext    ----//

/// Lua LLVMContext metatable
#define CONTEXT_METATABLE "LLVMContext"

/** Get a LLVMContextRef from Lua stack    [-0, +0, e]
 *
 * @param L Lua state
 * @param index Index of udata
 *
 * @return LLVM Context
 *
 * @throw If value is not a LLVMContext
 */
LLVMContextRef checkContext (lua_State *L, int index);

/** Push a LLVMContextRef into the Lua stack (as light userdata)   [-0, +1, -]
 *
 * @param L Lua state
 * @param ctx LLVM Context to be pushed
 */
void pushContext (lua_State *L, LLVMContextRef ctx);


//----    LLVMModule    ----//

/// Lua LLVMModule metatable
#define MODULE_METATABLE "LLVMModule"

/** Get a LLVMModuleRef from Lua stack    [-0, +0, e]
 *
 * @param L Lua state
 * @param index Index of udata
 *
 * @return LLVM Module
 *
 * @throw If value is not a LLVMModule
 */
LLVMModuleRef checkModule (lua_State *L, int index);

/** Push a LLVMModuleRef into the Lua stack (as light userdata)   [-0, +1, -]
 *
 * @param L Lua state
 * @param ctx LLVM Context to be pushed
 */
void pushModule (lua_State *L, LLVMModuleRef mod);

extern "C" {
	/// Open sesa... , I mean, LLVM core!
	int luaopen_lualvm_core (lua_State *L);
}

