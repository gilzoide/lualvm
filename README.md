lualvm
======
Lua wrapper for the LLVM-C API. It uses [SWIG](http://swig.org/) for bindings,
and then making wrappings around that more Lua friendly.


What works
----------
For now, only bindings for the LLVM-C Core is there, as wrappings will be added
further. We don't want bindings only, but you can add the header files in the
[SWIG interface](src/llvm.i) if you want.


Dependencies
------------
- [lua](http://www.lua.org/) >= 5.2
- [LLVM](http://llvm.org/) version 3.8
- [SWIG](http://swig.org/) (for building)


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
Lua API documented using [ldoc](https://github.com/stevedonovan/LDoc), `cd
ldoc` and generate docs with `ldoc .`
