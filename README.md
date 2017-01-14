lualvm
======
Lua wrapper for the [LLVM-C](http://www.llvm.org/docs/doxygen/html/group__LLVMC.html)
API. It uses [inclua](https://github.com/gilzoide/inclua) for generating
bindings, and then making wrappings around that more Lua friendly.


Dependencies
------------
- [lua](http://www.lua.org/) >= 5.2
- [LLVM](http://llvm.org/) (tested with version 3.9, but should work with others)
- [inclua](https://github.com/gilzoide/inclua) (for building)
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
Using [LuaRocks](https://luarocks.org/):

    # luarocks install lualvm

Using [make](https://www.gnu.org/software/make/) directly (after building with
cmake):

    # make install


What's missing?
---------------
- The following headers: Disassembler.h (function pointers or useless),
  LinkTimeOptimizer.h and lto.h (different API, maybe will be put in another
  module) and OrcBindings.h (unstable API)
- Document Lua API
- Make Kaleidoscope tutorial

Even though, _lualvm_ is ready for use!


Documentation
-------------
Lua API will be documented using [ldoc](https://github.com/stevedonovan/LDoc).
