--- @module lualvm.core.context
-- [LLVM-C Context](http://www.llvm.org/docs/doxygen/html/group__LLVMCCoreContext.html)
-- functions, usually accessed in Lua through the `LLVMContext` methods

--- Create a new LLVMModule associated with Context
--
-- @Context ctx Context
-- @string name Module's name
--
-- @treturn LLVMModule
function Module (ctx, name) end

--- Return a unique non-zero ID for the specified metadata kind in context
-- 
-- @Context ctx Context
-- @string mdKind Metadata kind name
--
-- @treturn int Metadata kind unique ID
function getMDKindID (ctx, mdKind) end

--- Get Context string representation, which is it's address (like lua functions)
-- 
-- @Context ctx Context
--
-- @treturn string "LLVMContext: 0xADDRESS"
function __tostring (ctx) end


--------------------------------------------------------------------------------
-- Integer Types
-- @section Integer

--- Get i1 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType i1
function getInt1 (ctx) end

--- Get i8 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType i8
function getInt8 (ctx) end

--- Get i16 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType i16
function getInt16 (ctx) end

--- Get i32 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType i32
function getInt32 (ctx) end

--- Get i64 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType i64
function getInt64 (ctx) end

--- Get i128 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType i128
function getInt128 (ctx) end

--- Get iN type in context
--
-- @Context ctx Context
-- @int N Number of bits for integer type
--
-- @treturn LLVMType iN
function getInt (ctx, N) end


--------------------------------------------------------------------------------
-- Floating Point Types
-- @section Float

--- Get half type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType half
function getHalf (ctx) end

--- Get float type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType float
function getFloat (ctx) end

--- Get double type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType double
function getDouble (ctx) end

--- Get X86FP80 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType X86FP80
function getX86FP80 (ctx) end

--- Get FP128 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType FP128
function getFP128 (ctx) end

--- Get PPCFP128 type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType PPCFP128
function getPPCFP128 (ctx) end


--------------------------------------------------------------------------------
-- Struct Types
-- @section Struct

--- Create a new Structure type in context
-- 
-- @Context ctx Context
-- @table[opt={}] elemTypes Table with the element types
-- @bool[opt=false] packed Should Struct be packed?
function Struct (ctx, elemTypes, packed) end


--- Create an empty structure in a context having a specified name
--
-- @Context ctx Context
-- @string name Struct name
--
-- @treturn LLVMType New named Struct
function NamedStruct (ctx, name) end


--------------------------------------------------------------------------------
-- Other Types
-- @section Other

--- Get void type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType void
function getVoid (ctx) end

--- Get label type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType label
function getLabel (ctx) end

--- Get x86_mmx type in context
--
-- @Context ctx Context
--
-- @treturn LLVMType x86_mmx
function getX86MMX (ctx) end
