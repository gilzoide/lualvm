#include <iostream>
#include <lua.hpp>

const struct luaL_Reg lualvmLib[] {
	{ NULL, NULL },
};

extern "C" {
	int luaopen_lualvm (lua_State *L) {
		luaL_newlib (L, lualvmLib);
		return 1;
	}
}
