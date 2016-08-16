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

#include "core/module.hpp"
#include "core/context.hpp"

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


/// Set inline assembly for a module
int moduleSetInlineAsm (lua_State *L) {
	auto mod = checkModule (L, 1);
	auto inlineAsm = luaL_checkstring (L, 2);
	LLVMSetModuleInlineAsm (mod, inlineAsm);
	return 0;
}


// LLVMModule Lua methods
const struct luaL_Reg lib[] {
	{ "clone", moduleClone },
	{ "dump", moduleDump },
	{ "getContext", moduleGetContext },
	{ "getDataLayout", moduleGetDataLayout },
	{ "setDataLayout", moduleSetDataLayout },
	{ "getTarget", moduleGetTarget },
	{ "setTarget", moduleSetTarget },
	{ "toFile", moduleToFile },
	{ "setInlineAsm", moduleSetInlineAsm },
	{ "__gc", moduleDispose },
	{ "__tostring", moduleToString },
	{ NULL, NULL }
};
extern "C" {
	int luaopen_lualvm_core_module (lua_State *L) {
		//--  module metatable  --//
		registerLuaMetatable (L, MODULE_METATABLE, lib);
		return 1;
	}
}
