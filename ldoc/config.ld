project = 'lualvm'
title = 'lualvm'
description = 'A Lua wrapper for the LLVM-C API'
full_description = [[
LuaLVM is a wrapper for the LLVM-C API built around LLVM 3.8 and Lua >= 5.2

Final users should use mainly the `lualvm` module, as it abstracts away much of
the LLVM-C bindings, that are included in this package as well
]]

format = 'markdown'
not_luadoc = true
merge = true

file = {'core'}
readme = '../README.md'

--//  add custom types for parameters  //--
-- builtin Lua types
tparam_alias ('string', 'string')
tparam_alias ('number', 'number')
tparam_alias ('int', 'int')
tparam_alias ('bool', 'bool')
-- LLVM types
tparam_alias ('Context', 'LLVMContext')
tparam_alias ('Module', 'LLVMModule')
