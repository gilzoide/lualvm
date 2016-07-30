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

--- Get Module's data layout string
--
-- @Module mod Module
--
-- @treturn string Data layout
function core.module.getDataLayout (mod) end

--- Set Module's data layout string
--
-- @Module mod Module
-- @string[opt=''] triple New data layout
--
-- @raise When triple isn't a valid data layout string
function core.module.setDataLayout (mod, triple) end

--- Get Module's target string
--
-- @Module mod Module
--
-- @treturn string Target triple
function core.module.getTarget (mod) end

--- Set Module's target string
--
-- @Module mod Module
-- @string[opt=''] triple New target
function core.module.setTarget (mod, triple) end

--- Print Module representation to file `file`.
--
-- This function works nicelly with Lua's `assert`
--
-- @Module mod Module
-- @string file Output file name
--
-- @return `True` on success, `nil` on error
-- @return Error string on error
function core.module.toFile (mod, file) end

--- Get Module string representation, which is it's dump in IR text code
-- 
-- @Module mod Module
--
-- @treturn string Module representation
function core.module.__tostring (mod) end
