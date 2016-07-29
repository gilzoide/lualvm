--- @module lualvm.core
-- [LLVM-C Core](http://www.llvm.org/docs/doxygen/html/group__LLVMCCore.html)
-- functions

--- Create a new Context
-- @treturn LLVMContext The new Context
function core.Context () end

--- Gets LLVM global Context
-- @treturn LLVMContext The global Context
function core.getGlobalContext () end

--- Create a new Module in the global Context
--
-- @string name Module's name
--
-- @treturn LLVMModule The new Module
function core.Module (name) end
