--- @classmod LLVMContext
-- LLVM Contexts, automatically gc'ed by Lua (no need to call `context:dispose ()`
-- or anything)
--
-- Every method here is a function from the `lualvm.core.context` module
-- applied to self

--- Create a new LLVMModule associated with self
--
-- @string name Module's name
--
-- @treturn LLVMModule
function LLVMContext:Module (name) end

--- Return a unique non-zero ID for the specified metadata kind in context
-- 
-- @string mdKind Metadata kind name
--
-- @treturn int Metadata kind unique ID
function LLVMContext:getMDKindID (mdKind) end

--- Get Context string representation, which is it's address (like lua functions)
--
-- @treturn string "LLVMContext: 0xADDRESS"
function LLVMContext:__tostring () end
