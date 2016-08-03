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
	auto ty = checkType (L, 1);
	auto width = LLVMGetIntTypeWidth (ty);
	lua_pushinteger (L, width);
	return 1;
}
//--  Float types --//
constructBuiltinType (Half);
constructBuiltinType (Float);
constructBuiltinType (Double);
constructBuiltinType (X86FP80);
constructBuiltinType (FP128);
constructBuiltinType (PPCFP128);
//--  Function types --//
/// Obtain the function type with the specified signature
int typeFunction (lua_State *L) {
	auto retType = checkType (L, 1);
	unsigned paramCount;
	// got table? If so, count params
	if (!lua_isnoneornil (L, 2)) {
		lua_len (L, 2);
		paramCount = lua_tointeger (L, -1);
		lua_pop (L, 1);
	}
	else {
		paramCount = 0;
	}
	
	// our parameters array, stack allocated =P
	auto params = new LLVMTypeRef [paramCount];
	// get each type from the table, and add it to the array
	for (unsigned i = 0; i < paramCount; i++) {
		lua_geti (L, 2, i + 1);
		auto ty = checkType (L, -1);
		params[i] = ty;
	}
	// and pop whatever we used in this
	lua_pop (L, paramCount);

	// construct the type, and push it
	auto theType = LLVMFunctionType (retType, params, paramCount,
			lua_toboolean (L, 3));
	pushType (L, theType);

	// delete the auxiliary array, pliz
	delete[] params;

	return 1;
}


/// Boolean if function is vararg
int typeIsFunctionVarArg (lua_State *L) {
	auto ty = checkType (L, 1);
	// assert Function type
	luaL_argcheck (L, LLVMGetTypeKind (ty) == LLVMFunctionTypeKind, 1,
			"type should be a Function type");
	lua_pushboolean (L, LLVMIsFunctionVarArg (ty));
	return 1;
}


/// Get function's return type
int typeGetReturn (lua_State *L) {
	auto ty = checkType (L, 1);
	// assert Function type
	luaL_argcheck (L, LLVMGetTypeKind (ty) == LLVMFunctionTypeKind, 1,
			"type should be a Function type");
	pushType (L, LLVMGetReturnType (ty));
	return 1;
}


/// Get the parameter count
int typeCountParam (lua_State *L) {
	auto ty = checkType (L, 1);
	// assert Function type
	luaL_argcheck (L, LLVMGetTypeKind (ty) == LLVMFunctionTypeKind, 1,
			"type should be a Function type");
	lua_pushinteger (L, LLVMCountParamTypes (ty));
	return 1;
}


/// Get a table with the parameter types
int typeGetParamTypes (lua_State *L) {
	auto ty = checkType (L, 1);
	// assert Function type
	luaL_argcheck (L, LLVMGetTypeKind (ty) == LLVMFunctionTypeKind, 1,
			"type should be a Function type");

	auto paramCount = LLVMCountParamTypes (ty);
	auto params = new LLVMTypeRef [paramCount];
	LLVMGetParamTypes (ty, params);

	lua_newtable (L);
	for (unsigned i = 0; i < paramCount; i++) {
		pushType (L, params[i]);
		lua_seti (L, -2, i + 1);
	}

	return 1;
}
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
	{ "getHalf", getHalfType },
	{ "getFloat", getFloatType },
	{ "getDouble", getDoubleType },
	{ "getX86FP80", getX86FP80Type },
	{ "getFP128", getFP128Type },
	{ "getPPCFP128", getPPCFP128Type },
	// functions
	{ "Function", typeFunction },
	{ "isVarArg", typeIsFunctionVarArg },
	{ "getReturn", typeGetReturn },
	{ "__len", typeCountParam },
	{ "getParamTypes", typeGetParamTypes },
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
