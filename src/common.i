/* Copyright 2016 Gil Barbosa Reis <gilzoide@gmail.com>
 * This file is part of Lualvm.
 *
 * Lualvm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Lualvm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Lualvm.  If not, see <http://www.gnu.org/licenses/>.
 */
/// Common stuff for all LLVM bits

%{
#include <llvm-c/Core.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
%}

%include <typemaps.i>

// Let bool be bool, so Lua use bools instead of ints =P
%ignore LLVMBool;
typedef bool LLVMBool;

// Every "char **" argument is output string, and should be dealt with
%typemap (in, numinputs = 0) char ** (char *temp) {
    temp = NULL;
    $1 = &temp;
}
%typemap (argout) char ** {
    if (*$1) {
        lua_pushstring (L, *$1); SWIG_arg++;
    }
}
%typemap (freearg) char ** {
    if (*$1) LLVMDisposeMessage (*$1);
}

// Strip the prepending "LLVM" from functions, so we use Lua's module as namespace
%rename ("%(strip:[LLVM])s") "";
