package = 'LuaLVM'
version = '0.1-1'
source = {
	url = 'https://github.com/gilzoide/lualvm',
}
description = {
	summary = 'Lua wrapper for the LLVM-C API',
	detailed = [[
		LuaLVM is a Lua wrapper around the LLVM-C API, using LLVM version 3.8
	]],
	license = 'GPLv3',
	maintainer = 'gilzoide <gilzoide@gmail.com>'
}
dependencies = {
	'lua >= 5.2'
}
external_dependencies = {
	LIBLLVM = {
		header = 'llvm-c/Core.h'
	}
}
build = {
	type = 'make',
	makefile = 'makefile',
	build_variables = {
		CFLAGS = '$(CFLAGS)',
		LIBFLAG = '$(LIBFLAG)',
		LUA_LIBDIR = '$(LUA_LIBDIR)',
		LUA_BINDIR = '$(LUA_BINDIR)',
		LUA_INCDIR = '$(LUA_INCDIR)',
		LUA = '$(LUA)',
	},
	install_variables = {
		PREFIX = '$(PREFIX)',
		BINDIR = '$(BINDIR)',
		LIBDIR = '$(LIBDIR)',
		LUADIR = '$(LUADIR)',
		CONFDIR = '$(CONFDIR)',
	},
}
