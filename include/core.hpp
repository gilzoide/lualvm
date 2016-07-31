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
 * @param i Index of udata
 *
 * @return LLVM Context
 *
 * @throw If value is not a LLVMContext
 */
#define checkContext(L, i) \
	lualvm_check<LLVMContextRef> (L, i, CONTEXT_METATABLE)

/** Push a LLVMContextRef into the Lua stack (as light userdata)   [-0, +1, -]
 *
 * @param L Lua state
 * @param ctx LLVM Context to be pushed
 */
#define pushContext(L, ctx) \
	lualvm_push<LLVMContextRef> (L, ctx, CONTEXT_METATABLE)

/**
 * Push a managed Context to Lua, so that it is garbage collected
 * 
 * Use only when creating new Contexts
 */
#define pushManagedContext(L, ctx) \
	lualvm_pushManaged<LLVMContextRef> (L, ctx, CONTEXT_METATABLE)


//----    LLVMModule    ----//

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


//----    LLVMType    ----//

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


//----    Core    ----//
extern "C" {
	/// Open sesa... , I mean, LLVM core!
	int luaopen_lualvm_core (lua_State *L);

	// I know these constructs don't work for requiring directly from Lua,
	// but it's nice to put it according to the music. Maybe separate it all
	// later

	/// and core.context
	int luaopen_lualvm_core_context (lua_State *L);
	/// core.module
	int luaopen_lualvm_core_module (lua_State *L);
	/// core.ty... ah, you got it, right?
	int luaopen_lualvm_core_type (lua_State *L);
}

