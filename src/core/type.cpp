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

/// Gets type kind, enum value
int typeGetKind (lua_State *L) {
	auto ty = checkType (L, 1);
	auto kind = LLVMGetTypeKind (ty);
	lua_pushinteger (L, kind);
	return 1;
}


/// Bool if type is sized
int typeIsSized (lua_State *L) {
	auto ty = checkType (L, 1);
	lua_pushboolean (L, LLVMTypeIsSized (ty));
	return 1;
}


/// Get context to which type is associated
int typeGetContext (lua_State *L) {
	auto ty = checkType (L, 1);
	auto ctx = LLVMGetTypeContext (ty);
	pushContext (L, ctx);
	return 1;
}


/// Dump type to stderr
int typeDump (lua_State *L) {
	auto ty = checkType (L, 1);
	LLVMDumpType (ty);
	return 0;
}


/// String representation of type
int typeToString (lua_State *L) {
	auto ty = checkType (L, 1);
	auto str = LLVMPrintTypeToString (ty);
	lua_pushstring (L, str);
	// yup, C baby, LIBERA SAPORRA O QUANTO ANTES
	LLVMDisposeMessage (str);
	return 1;
}

/// Macro that inserts builtin Type getters for global context
#define constructBuiltinType(ty) \
	int get ## ty ## Type (lua_State *L) { \
		auto type = LLVM ## ty ## Type (); \
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
int getIntType (lua_State *L) {
	auto numBits = luaL_checkinteger (L, 1);
	pushType (L, LLVMIntType (numBits));
	return 1;
}
/// Get Int type width
int typeGetIntWidth (lua_State *L) {
	auto ty = checkType (L, -1);
	auto width = LLVMGetIntTypeWidth (ty);
	lua_pushinteger (L, width);
	return 1;
}
//--  Float types --//
constructBuiltinType (Float);
//--  Other types --//
constructBuiltinType (Void);
constructBuiltinType (Label);
constructBuiltinType (X86MMX);


// LLVMContext Lua methods
const struct luaL_Reg lib[] {
	{ "getKind", typeGetKind },
	{ "isSized", typeIsSized },
	{ "getContext", typeGetContext },
	{ "dump", typeDump },
	{ "__tostring", typeToString },
	// ints
	{ "getInt1", getInt1Type },
	{ "getInt8", getInt8Type },
	{ "getInt16", getInt16Type },
	{ "getInt32", getInt32Type },
	{ "getInt64", getInt64Type },
	{ "getInt128", getInt128Type },
	{ "getInt", getIntType },
	{ "getIntWidth", typeGetIntWidth },
	// floats
	{ "getFloat", getFloatType },
	// other
	{ "getVoid", getVoidType },
	{ "getLabel", getLabelType },
	{ "getX86MMX", getX86MMXType },
	{ NULL, NULL }
};
extern "C" {
	int luaopen_lualvm_core_type (lua_State *L) {
		//--  type metatable  --//
		registerLuaMetatable (L, TYPE_METATABLE, lib);
		return 1;
	}
}
