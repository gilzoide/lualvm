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
#include "core_enums.hpp"

//----    lualvm API    ----//


/**
 * Push a managed Context to Lua, so that it is garbage collected
 * 
 * Use only when creating new Contexts (it's not in the header, so it's cool)
 */
#define pushManagedContext(L, ctx) \
	lualvm_pushManaged<LLVMContextRef> (L, ctx, CONTEXT_METATABLE)


/**
 * Push a managed Module to Lua, so that it is garbage collected
 * 
 * Use only when creating new Module (it's not in the header, so it's cool)
 */
#define pushManagedModule(L, mod) \
	lualvm_pushManaged<LLVMModuleRef> (L, mod, MODULE_METATABLE)


//----    lualvm.core module    ----//

/// Create a new Context
int contextCreate (lua_State *L) {
	auto ctx = LLVMContextCreate ();
	pushManagedContext (L, ctx);
	return 1;
}


/// Create a new Module in global Context
int moduleCreate (lua_State *L) {
	auto moduleName = luaL_checkstring (L, 1);
	auto mod = LLVMModuleCreateWithName (moduleName);
	pushManagedModule (L, mod);
	return 1;
}


/// Get the Global Context
int getGlobalContext (lua_State *L) {
	auto ctx = LLVMGetGlobalContext ();
	pushContext (L, ctx);
	return 1;
}


/// Get MDKindId in global context
int getMDKindID (lua_State *L) {
	auto ctx = LLVMGetGlobalContext ();
	size_t len;
	auto name = luaL_checklstring (L, 1, &len);
	auto mdKindId = LLVMGetMDKindIDInContext (ctx, name, len);
	lua_pushinteger (L, mdKindId);
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
	pushManagedModule (L, mod);
	return 1;
}


/// Return "LLVMContext: <userdata>"
int contextToString (lua_State *L) {
	auto ctx = checkContext (L, 1);
	lua_pushfstring (L, CONTEXT_METATABLE ": %p", (void *) ctx);
	return 1;
}


/// Return a unique non-zero ID for the specified metadata kind in Context
int contextGetMDKindID (lua_State *L) {
	auto ctx = checkContext (L, 1);
	size_t len;
	auto name = luaL_checklstring (L, 2, &len);
	auto mdKindId = LLVMGetMDKindIDInContext (ctx, name, len);
	lua_pushinteger (L, mdKindId);
	return 1;
}


//----    LLVMModule methods    ----//

/// "Obtain the context to which this module is associated."
int moduleGetContext (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto ctx = LLVMGetModuleContext (mod);
	pushContext (L, ctx);
	return 1;
}


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


/// Get the data layout from the Module
int moduleGetDataLayout (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto dataLayout = LLVMGetDataLayout (mod);
	lua_pushstring (L, dataLayout);
	return 1;
}


/// Set the data layout for Module
int moduleSetDataLayout (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto triple = luaL_optstring (L, 2, "");
	LLVMSetDataLayout (mod, triple);
	return 0;
}


/// Get target triple from Module
int moduleGetTarget (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto target = LLVMGetTarget (mod);
	lua_pushstring (L, target);
	return 1;
}


/// Set target triple for Module
int moduleSetTarget (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto triple = luaL_optstring (L, 2, "");
	LLVMSetTarget (mod, triple);
	return 0;
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


/// Write Module to file
int moduleToFile (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto file = luaL_checkstring (L, 2);
	// why not return the error directly in the function? Returns a bool, and
	// writes error to a stack string =/
	char *errmsg;
	// success, send 'true', so it can be asserted
	if (!LLVMPrintModuleToFile (mod, file, &errmsg)) {
		lua_pushboolean (L, 1);
		return 1;
	}
	// oops, error...
	else {
		lua_pushnil (L);
		lua_pushfstring (L, "Can't write module to file: %s", errmsg);
		LLVMDisposeMessage (errmsg);
		return 2;
	}
}


// Ok, Ok, enough with these macros
#undef pushManagedContext
#undef pushManagedModule


//----    Lua Funcs to be registered    ----//

// lualvm.core functions
const struct luaL_Reg lualvmLib[] {
	{ "Context", contextCreate },
	{ "Module", moduleCreate },
	{ "getGlobalContext", getGlobalContext },
	{ "getMDKindID", getMDKindID },
	{ NULL, NULL }
};

// LLVMContext Lua methods
const struct luaL_Reg contextLib[] {
	{ "Module", contextModuleCreate },
	{ "getMDKindID", contextGetMDKindID },
	{ "__gc", contextDispose },
	{ "__tostring", contextToString },
	{ NULL, NULL }
};

// LLVMModule Lua methods
const struct luaL_Reg moduleLib[] {
	{ "clone", moduleClone },
	{ "dump", moduleDump },
	{ "getContext", moduleGetContext },
	{ "getDataLayout", moduleGetDataLayout },
	{ "setDataLayout", moduleSetDataLayout },
	{ "getTarget", moduleGetTarget },
	{ "setTarget", moduleSetTarget },
	{ "toFile", moduleToFile },
	{ "__gc", moduleDispose },
	{ "__tostring", moduleToString },
	{ NULL, NULL }
};


extern "C" {
	int luaopen_lualvm_core (lua_State *L) {
		//--  the module itself  --//
		luaL_newlib (L, lualvmLib);
		registerCoreEnums (L);

		//--  context metatable  --//
		registerLuaMetatable (L, CONTEXT_METATABLE, contextLib);
		lua_setfield (L, -2, "context");

		//--  module metatable  --//
		registerLuaMetatable (L, MODULE_METATABLE, moduleLib);
		lua_setfield (L, -2, "module");

		return 1;
	}
}
