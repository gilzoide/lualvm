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


//----    lualvm.core module    ----//

int contextCreate (lua_State *L) {
	auto ctx = LLVMContextCreate ();
	pushContext (L, ctx);
	return 1;
}


//----    LLVMContext methods    ----//

int contextDispose (lua_State *L) {
	auto ctx = checkContext (L, 1);
	LLVMContextDispose (ctx);
	return 0;
}

// MACRO that avoids mispelling =P
#define sameName(f) \
	{ #f, f }

// lualvm.core functions
const struct luaL_Reg lualvmLib[] {
	sameName (contextCreate),
	{ NULL, NULL }
};

// LLVMContext Lua methods
const struct luaL_Reg contextLib[] {
	{ "__gc", contextDispose },
	{ NULL, NULL }
};


extern "C" {
	int luaopen_lualvm_core (lua_State *L) {
		//--  context metatable  --//
		luaL_newmetatable (L, CONTEXT_METATABLE);
		luaL_setfuncs (L, contextLib, 0);
		// and give it a nice name, already consuming it ^^
		lua_pushliteral (L, CONTEXT_METATABLE);
		lua_setfield (L, -2, "__metatable");

		//--  the module itself  --//
		luaL_newlib (L, lualvmLib);
		return 1;
	}
}
