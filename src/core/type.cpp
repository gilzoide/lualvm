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
#include "core/context.hpp"
#include "core/type.hpp"

/// Util: check if type is an Integer type
void assertIntegerType (lua_State *L, LLVMTypeRef ty, int idx = 1) {
	// assert Function type
	luaL_argcheck (L, LLVMGetTypeKind (ty) == LLVMIntegerTypeKind, idx,
			"type should be an Integer type");
}
/// Util: check if type is a Function type
void assertFunctionType (lua_State *L, LLVMTypeRef ty, int idx = 1) {
	// assert Function type
	luaL_argcheck (L, LLVMGetTypeKind (ty) == LLVMFunctionTypeKind, idx,
			"type should be a Function type");
}
/// Util: check if type is a Struct type
void assertStructType (lua_State *L, LLVMTypeRef ty, int idx = 1) {
	// assert Function type
	luaL_argcheck (L, LLVMGetTypeKind (ty) == LLVMStructTypeKind, idx,
			"type should be a Struct type");
}

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

//--  Int types  --//
/// Get Int type width
int typeGetIntWidth (lua_State *L) {
	auto ty = checkType (L, 1);
	assertIntegerType (L, ty);
	auto width = LLVMGetIntTypeWidth (ty);
	lua_pushinteger (L, width);
	return 1;
}
//--  Function types --//
/// Obtain the function type with the specified signature in global context
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
	assertFunctionType (L, ty);
	lua_pushboolean (L, LLVMIsFunctionVarArg (ty));
	return 1;
}


/// Get function's return type
int typeGetReturn (lua_State *L) {
	auto ty = checkType (L, 1);
	assertFunctionType (L, ty);
	pushType (L, LLVMGetReturnType (ty));
	return 1;
}


/// Get the parameter count
int typeCountParam (lua_State *L) {
	auto ty = checkType (L, 1);
	assertFunctionType (L, ty);
	lua_pushinteger (L, LLVMCountParamTypes (ty));
	return 1;
}


/// Get a table with the parameter types
int typeGetParamTypes (lua_State *L) {
	auto ty = checkType (L, 1);
	assertFunctionType (L, ty);

	auto paramCount = LLVMCountParamTypes (ty);
	auto params = new LLVMTypeRef [paramCount];
	LLVMGetParamTypes (ty, params);

	lua_newtable (L);
	for (unsigned i = 0; i < paramCount; i++) {
		pushType (L, params[i]);
		lua_seti (L, -2, i + 1);
	}

	delete[] params;

	return 1;
}
//--  Struct types --//
/// Get name struct's name
int typeGetStructName (lua_State *L) {
	auto ty = checkType (L, 1);
	assertStructType (L, ty);
	
	auto name = LLVMGetStructName (ty);
	lua_pushstring (L, name);
	return 1;
}


/// Set the contents of an opaque structure type
int typeSetStructBody (lua_State *L) {
	auto ty = checkType (L, 1);
	assertStructType (L, ty);

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

	// set struct's body
	LLVMStructSetBody (ty, elemTypes, elemCount, lua_toboolean (L, 3));

	// delete the auxiliary array, pliz
	delete[] elemTypes;

	return 0;
}


/// Get Struct element count
int typeCountElements (lua_State *L) {
	auto ty = checkType (L, -1);
	assertStructType (L, ty);

	auto count = LLVMCountStructElementTypes (ty);
	lua_pushinteger (L, count);
	return 1;
}


/// Get Struct element types in a table
int typeGetElementTypes (lua_State *L) {
	auto ty = checkType (L, 1);
	assertStructType (L, ty);

	auto elemCount = LLVMCountStructElementTypes (ty);
	auto elems = new LLVMTypeRef [elemCount];
	LLVMGetStructElementTypes (ty, elems);

	lua_newtable (L);
	for (unsigned i = 0; i < elemCount; i++) {
		pushType (L, elems[i]);
		lua_seti (L, -2, i + 1);
	}

	delete[] elems;

	return 1;
}


/// Get the type of the element at a given index in the structure
int typeGetTypeAtIndex (lua_State *L) {
	auto ty = checkType (L, 1);
	assertStructType (L, ty);

	auto idx = luaL_checkinteger (L, 2);
	auto typeAtIndex = LLVMStructGetTypeAtIndex (ty, idx - 1);
	pushType (L, typeAtIndex);
	return 1;
}


/// Is Struct packed?
int typeIsPacked (lua_State *L) {
	auto ty = checkType (L, 1);
	assertStructType (L, ty);
	lua_pushboolean (L, LLVMIsPackedStruct (ty));
	return 1;
}


/// Is Struct opaque?
int typeIsOpaque (lua_State *L) {
	auto ty = checkType (L, 1);
	assertStructType (L, ty);
	lua_pushboolean (L, LLVMIsOpaqueStruct (ty));
	return 1;
}


// LLVMType Lua methods
const struct luaL_Reg lib[] {
	{ "getKind", typeGetKind },
	{ "isSized", typeIsSized },
	{ "getContext", typeGetContext },
	{ "dump", typeDump },
	{ "__tostring", typeToString },
	// ints
	{ "getIntWidth", typeGetIntWidth },
	// functions
	{ "Function", typeFunction },
	{ "isVarArg", typeIsFunctionVarArg },
	{ "getReturn", typeGetReturn },
	{ "countParams", typeCountParam },
	{ "getParamTypes", typeGetParamTypes },
	// structs
	{ "getName", typeGetStructName },
	{ "setBody", typeSetStructBody },
	{ "countElements", typeCountElements },
	{ "getElementTypes", typeGetElementTypes },
	{ "getTypeAtIndex", typeGetTypeAtIndex },
	{ "isPacked", typeIsPacked },
	{ "isOpaque", typeIsOpaque },
	{ NULL, NULL }
};
extern "C" {
	int luaopen_lualvm_core_type (lua_State *L) {
		//--  type metatable  --//
		registerLuaMetatable (L, TYPE_METATABLE, lib);
		return 1;
	}
}
