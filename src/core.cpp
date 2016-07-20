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

#include "core.hpp"

//----    lualvm API    ----//

LLVMContextRef checkContext (lua_State *L, int index) {
	LLVMContextRef *pointer, ctx;
	pointer = (LLVMContextRef *) luaL_checkudata (L, index, CONTEXT_METATABLE);
	ctx = *pointer;
	if (!ctx) {
		luaL_error (L, "null LLVMContext");
	}

	return ctx;
}


void pushContext (lua_State *L, LLVMContextRef ctx) {
	auto pointer = (LLVMContextRef *) lua_newuserdata (L, sizeof (LLVMContextRef));
	*pointer = ctx;
	luaL_getmetatable (L, CONTEXT_METATABLE);
	lua_setmetatable (L, -2);
}


LLVMModuleRef checkModule (lua_State *L, int index) {
	LLVMModuleRef *pointer, mod;
	pointer = (LLVMModuleRef *) luaL_checkudata (L, index, MODULE_METATABLE);
	mod = *pointer;
	if (!mod) {
		luaL_error (L, "null LLVMModule");
	}

	return mod;
}


void pushModule (lua_State *L, LLVMModuleRef mod) {
	auto pointer = (LLVMModuleRef *) lua_newuserdata (L, sizeof (LLVMModuleRef));
	*pointer = mod;
	luaL_getmetatable (L, MODULE_METATABLE);
	lua_setmetatable (L, -2);
}


//----    lualvm.core module    ----//

/// Create a new Context
int contextCreate (lua_State *L) {
	auto ctx = LLVMContextCreate ();
	pushContext (L, ctx);
	return 1;
}


/// Create a new Module in global Context
int moduleCreate (lua_State *L) {
	auto moduleName = luaL_checkstring (L, 1);
	auto mod = LLVMModuleCreateWithName (moduleName);
	pushModule (L, mod);
	return 1;
}

//----    LLVMContext methods    ----//

/// Dispose Context, don't call it directly (let Lua GC do it)
int contextDispose (lua_State *L) {
	auto ctx = checkContext (L, 1);
	LLVMContextDispose (ctx);
	return 0;
}


/// Create Module within Context
int contextModuleCreate (lua_State *L) {
	auto ctx = checkContext (L, 1);
	auto moduleName = luaL_checkstring (L, 2);
	auto mod = LLVMModuleCreateWithNameInContext (moduleName, ctx);
	pushModule (L, mod);
	return 1;
}


//----    LLVMModule methods    ----//

/// Dispose Module, don't call it directly (let Lua GC do it)
int moduleDispose (lua_State *L) {
	auto mod = checkModule (L, 1);
	LLVMDisposeModule (mod);
	return 0;
}


/// Dump Module
int moduleDump (lua_State *L) {
	auto mod = checkModule (L, 1);
	LLVMDumpModule (mod);
	return 0;
}


/// Clone Module
int moduleClone (lua_State *L) {
	auto mod = checkModule (L, 1);
	pushModule (L, LLVMCloneModule (mod));
	return 1;
}


/// Get stringified version of Module, to be used in Lua as `tostring (mod)`
int moduleToString (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto str = LLVMPrintModuleToString (mod);
	lua_pushstring (L, str);

	// always remember to free your strings
	LLVMDisposeMessage (str);
	return 1;
}


//----    Lua Funcs to be registered    ----//
// lualvm.core functions
const struct luaL_Reg lualvmLib[] {
	{ "contextCreate", contextCreate },
	{ "moduleCreate", moduleCreate },
	{ NULL, NULL }
};

// LLVMContext Lua methods
const struct luaL_Reg contextLib[] {
	{ "moduleCreate", contextModuleCreate },
	{ "__gc", contextDispose },
	{ NULL, NULL }
};

// LLVMModule Lua methods
const struct luaL_Reg moduleLib[] {
	{ "clone", moduleClone },
	{ "dump", moduleDump },
	{ "__gc", moduleDispose },
	{ "__tostring", moduleToString },
	{ NULL, NULL }
};


extern "C" {
	int luaopen_lualvm_core (lua_State *L) {
		//--  context metatable  --//
		registerLuaMetatable (L, CONTEXT_METATABLE, contextLib);

		//--  module metatable  --//
		registerLuaMetatable (L, MODULE_METATABLE, moduleLib);

		//--  the module itself  --//
		luaL_newlib (L, lualvmLib);
		return 1;
	}
}
