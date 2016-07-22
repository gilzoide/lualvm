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

/** @file lualvm.hpp
 * Some common stuff, for internal lualvm use only
 */
#pragma once

// Lua includes
#include <lua.hpp>

// other stuff
#include <type_traits>


/**
 * Auxiliary function that register types in Lua    [+0, -0, -]
 *
 * This function register a new Metatable, setting it's "__metatable" field to
 * `tname` and it's "__index" field to the functions, so methods can be used
 *
 * @note This function doesn't leave the new metatable in Lua stack, get it
 * with `luaL_getmetatable`
 *
 * @param L Lua state
 * @param tname Metatable name
 * @param funcs Functions to be registered
 * @param nup Number of upvalues
 */
void registerLuaMetatable (lua_State *L, const char *tname, const luaL_Reg *funcs
		, int nup = 0) {
	// create the metatable
	luaL_newmetatable (L, tname);
	luaL_setfuncs (L, funcs, nup);
	// let "__index" point to the methods, so that we can use them
	// duplicate the table, as it'll be consumed by `setfield`
	lua_pushvalue (L, -1);
	lua_setfield (L, -2, "__index");
	// and give it a nice name, already consuming it ^^
	lua_pushstring (L, tname);
	lua_setfield (L, -2, "__metatable");
}


/**
 * Template for getting types from Lua, checking metatable
 *
 * @param L Lua state
 * @param index Lua stack index
 * @param metatable Metatable name to be checked
 *
 * @return Whatever T type userdata there was
 */
template<typename T>
T lualvm_check (lua_State *L, int index, const char *metatable) {
	auto pointer = luaL_checkudata (L, index, metatable);
	if (lua_islightuserdata (L, index)) {
		return static_cast<T> (pointer);
	}
	else {
		auto value = static_cast<T> (* static_cast<T *> (pointer));
		if (!value) {
			lua_pushfstring (L, "null %s", metatable);
			lua_error (L);
		}

		return value;
	}
}


/**
 *
 */
template<typename T>
void lualvm_pushManaged (lua_State *L, T value, const char *metatable) {
	auto pointer = (T *) lua_newuserdata (L, sizeof (T));
	*pointer = value;
	luaL_getmetatable (L, metatable);
	lua_setmetatable (L, -2);
}


template<typename T>
void lualvm_push (lua_State *L, T ptr, const char *metatable) {
	static_assert (std::is_pointer<T>::value, "Can't push Lua light userdata if it isn't a pointer!");
	lua_pushlightuserdata (L, ptr);
	luaL_getmetatable (L, metatable);
	lua_setmetatable (L, -2);
}
