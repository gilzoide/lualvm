package = 'LuaLVM'
version = 'scm-1'
source = {
	url = 'git://github.com/gilzoide/lualvm',
}
description = {
	summary = 'Lua wrapper for the LLVM-C API',
	detailed = [[
LuaLVM is a Lua wrapper around the LLVM-C API, tested on LLVM 3.9 (should work
with other versions)
]],
	license = 'LGPLv3',
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
	type = 'cmake',
	variables = {
		CMAKE_INSTALL_PREFIX = '$(PREFIX)',
		LUADIR = '$(LUADIR)',
		LIBDIR = '$(LIBDIR)',
	},
}
