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


// LLVMContext Lua methods
const struct luaL_Reg lib[] {
	{ "Module", contextModuleCreate },
	{ "getMDKindID", contextGetMDKindID },
	{ "__gc", contextDispose },
	{ "__tostring", contextToString },
	{ NULL, NULL }
};
extern "C" {
	int luaopen_lualvm_core_context (lua_State *L) {
		//--  context metatable  --//
		registerLuaMetatable (L, CONTEXT_METATABLE, lib);
		return 1;
	}
}
