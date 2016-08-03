--- @module lualvm.core.module
-- [LLVM-C Module](http://www.llvm.org/docs/doxygen/html/group__LLVMCCoreModule.html)
-- functions, usually accessed in Lua through the `LLVMModule` methods

--- Get the Context to which `mod` is associated
--
-- @Module mod Module
--
-- @treturn LLVMContext
function getContext (mod) end

--- Dump the Module representation to `stderr`
--
-- @Module mod Module
function dump (mod) end

--- Clone a Module
--
-- @Module mod Module
--
-- @treturn LLVMModule The clone
function clone (mod) end

--- Get Module's data layout string
--
-- @Module mod Module
--
-- @treturn string Data layout
function getDataLayout (mod) end

--- Set Module's data layout string
--
-- @Module mod Module
-- @string[opt=''] triple New data layout
--
-- @raise When triple isn't a valid data layout string
function setDataLayout (mod, triple) end

--- Get Module's target string
--
-- @Module mod Module
--
-- @treturn string Target triple
function getTarget (mod) end

--- Set Module's target string
--
-- @Module mod Module
-- @string[opt=''] triple New target
function setTarget (mod, triple) end

--- Print Module representation to file `file`.
--
-- This function works nicelly with Lua's `assert`
--
-- @Module mod Module
-- @string file Output file name
--
-- @return[1] true
-- @return[2] nil
-- @return[2] error message
function toFile (mod, file) end

--- Get Module string representation, which is it's dump in IR text code
-- 
-- @Module mod Module
--
-- @treturn string Module representation
function __tostring (mod) end


--- Set the module-scope inline assembly blocks.
--
-- A trailing newline is added if the input doesn't have one
--
-- @Module mod Module
-- @string asm Inline asm
function setInlineAsm (mod, asm) end
