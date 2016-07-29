--- @module lualvm.core.module
-- [LLVM-C Module](http://www.llvm.org/docs/doxygen/html/group__LLVMCCoreModule.html)
-- functions, usually accessed in Lua through the `LLVMModule` methods

--- Gets the Context with which mod is associated
--
-- @Module mod Module
--
-- @treturn LLVMContext
function core.module.getContext (mod) end

--- Dumps the Module representation to `stderr`
--
-- @Module mod Module
function core.module.dump (mod) end

--- Clone a Module
--
-- @Module mod Module
--
-- @treturn LLVMModule The clone
function core.module.clone (mod) end

--- Get Module string representation, which is it's dump in IR text code
-- 
-- @Module mod Module
--
-- @treturn string Module representation
function core.module.__tostring (mod) end
