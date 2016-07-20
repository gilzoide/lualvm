lualvm
======
Lua wrapper for the LLVM-C API


Dependencies
------------
- [lua](http://www.lua.org/) >= 5.2
- [LLVM](http://llvm.org/) version 3.8


Building
--------
With [make](https://www.gnu.org/software/make/):

    $ make

A C++11 compiler is required, as well as `llvm-config` being in `PATH`


Installing
----------
Using [LuaRocks](https://luarocks.org/) locally (no remote yet):

    # luarocks make

Using [make](https://www.gnu.org/software/make/) directly:

    # make install


Documentation
-------------
Everything is documented [doxygen](https://www.stack.nl/~dimitri/doxygen/) style
