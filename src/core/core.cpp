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


// lualvm.core functions
const struct luaL_Reg lib[] {
	{ "Context", contextCreate },
	{ "Module", moduleCreate },
	{ "getGlobalContext", getGlobalContext },
	{ "getMDKindID", getMDKindID },
	{ NULL, NULL }
};
extern "C" {
	int luaopen_lualvm_core (lua_State *L) {
		// the core module
		luaL_newlib (L, lib);
		// it's enums
		registerCoreEnums (L);
		// core.context
		luaopen_lualvm_core_context (L);
		lua_setfield (L, -2, "context");
		// core.module
		luaopen_lualvm_core_module (L);
		lua_setfield (L, -2, "module");
		// core.type
		luaopen_lualvm_core_type (L);
		lua_setfield (L, -2, "type");

		return 1;
	}
}
