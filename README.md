lualvm
======
Lua wrapper for the [LLVM-C](http://www.llvm.org/docs/doxygen/html/group__LLVMC.html)
API. It uses [SWIG](http://swig.org/) for bindings, and then making wrappings
around that more Lua friendly.


What works
----------
For now, only bindings for the LLVM-C Core is there, the other submodules, as
well as more Lua-style API will be added further.


Dependencies
------------
- [lua](http://www.lua.org/) >= 5.2
- [LLVM](http://llvm.org/)
- [SWIG](http://swig.org/) (for building)
- [CMake](https://cmake.org/) >= 2.8 (for building)


Building
--------
With [cmake](https://cmake.org/):

    $ mkdir build
	$ cd build
	$ cmake ..
	$ make


Installing
----------
Using [LuaRocks](https://luarocks.org/) locally (no remote yet):

    # luarocks make

Using [make](https://www.gnu.org/software/make/) directly (after building with
cmake):

    # make install


Documentation
-------------
Lua API will be documented using [ldoc](https://github.com/stevedonovan/LDoc).
