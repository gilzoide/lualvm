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

#include "core/context.hpp"
#include "core/module.hpp"
#include "core/type.hpp"

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

//----    Type Getters    ----//
/// Macro that inserts builtin Type getters for context
#define constructBuiltinType(ty) \
	int get ## ty ## TypeInContext (lua_State *L) { \
		auto ctx = checkContext (L, 1); \
		auto type = LLVM ## ty ## TypeInContext (ctx); \
		pushType (L, type); \
		return 1; \
	}

//--  Int types  --//
constructBuiltinType (Int1);
constructBuiltinType (Int8);
constructBuiltinType (Int16);
constructBuiltinType (Int32);
constructBuiltinType (Int64);
constructBuiltinType (Int128);
/// The arbitrary precision int
int getIntTypeInContext (lua_State *L) {
	auto ctx = checkContext (L, 1);
	auto numBits = luaL_checkinteger (L, 2);
	pushType (L, LLVMIntTypeInContext (ctx, numBits));
	return 1;
}
//--  Float types --//
constructBuiltinType (Half);
constructBuiltinType (Float);
constructBuiltinType (Double);
constructBuiltinType (X86FP80);
constructBuiltinType (FP128);
constructBuiltinType (PPCFP128);
//--  Struct type --//
/// Obtain the struct type with the specified signature
int getStructTypeInContext (lua_State *L) {
	auto ctx = checkContext (L, 1);
	unsigned elemCount;
	// got table? If so, count params
	if (!lua_isnoneornil (L, 2)) {
		lua_len (L, 2);
		elemCount = lua_tointeger (L, -1);
		lua_pop (L, 1);
	}
	else {
		elemCount = 0;
	}
	
	// our element types array
	auto elemTypes = new LLVMTypeRef [elemCount];
	// get each type from the table, and add it to the array
	for (unsigned i = 0; i < elemCount; i++) {
		lua_geti (L, 2, i + 1);
		auto ty = checkType (L, -1);
		elemTypes[i] = ty;
	}
	// and pop whatever we used in this
	lua_pop (L, elemCount);

	// construct the type, and push it
	auto theType = LLVMStructTypeInContext (ctx, elemTypes, elemCount
			, lua_toboolean (L, 3));
	pushType (L, theType);

	// delete the auxiliary array, pliz
	delete[] elemTypes;

	return 1;
}


/// Obtain empty struct in context having the specified name
int getNamedStruct (lua_State *L) {
	auto ctx = checkContext (L, 1);
	auto name = luaL_checkstring (L, 2);
	pushType (L, LLVMStructCreateNamed (ctx, name));
	return 1;
}
//--  Other types --//
constructBuiltinType (Void);
constructBuiltinType (Label);
constructBuiltinType (X86MMX);

// LLVMContext Lua methods
const struct luaL_Reg lib[] {
	{ "Module", contextModuleCreate },
	{ "getMDKindID", contextGetMDKindID },
	{ "__gc", contextDispose },
	{ "__tostring", contextToString },
	// LLVMType getters
	// ints
	{ "getInt1", getInt1TypeInContext },
	{ "getInt8", getInt8TypeInContext },
	{ "getInt16", getInt16TypeInContext },
	{ "getInt32", getInt32TypeInContext },
	{ "getInt64", getInt64TypeInContext },
	{ "getInt128", getInt128TypeInContext },
	{ "getInt", getIntTypeInContext },
	// floats
	{ "getHalf", getHalfTypeInContext },
	{ "getFloat", getFloatTypeInContext },
	{ "getDouble", getDoubleTypeInContext },
	{ "getX86FP80", getX86FP80TypeInContext },
	{ "getFP128", getFP128TypeInContext },
	{ "getPPCFP128", getPPCFP128TypeInContext },
	// structs
	{ "Struct", getStructTypeInContext },
	{ "NamedStruct", getNamedStruct },
	// other
	{ "getVoid", getVoidTypeInContext },
	{ "getLabel", getLabelTypeInContext },
	{ "getX86MMX", getX86MMXTypeInContext },
	{ NULL, NULL }
};
extern "C" {
	int luaopen_lualvm_core_context (lua_State *L) {
		registerLuaMetatable (L, CONTEXT_METATABLE, lib);
		return 1;
	}
}
