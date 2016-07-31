--- @module lualvm.core.type
-- [LLVM-C Type](http://www.llvm.org/docs/doxygen/html/group__LLVMCCoreType.html)
-- functions, usually accessed in Lua through the `LLVMType` methods

--- Gets the TypeKind enumeration
-- 
-- @Type ty Type
--
-- @treturn int Type kind
function getKind (ty) end

--- Whether the Type has known size
--
-- @Type ty Type
--
-- @treturn bool Is type sized
function isSized (ty) end

--- Get the Context to which `ty` is associated
--
-- @Type ty Type
--
-- @treturn LLVMContext
function getContext (ty) end

--- Dump Type representation to `stderr`
--
-- @Type ty Type
function dump (ty) end

--- Get Type string representation
--
-- @Type ty Type
--
-- @treturn string Type representation
function __tostring (ty) end


--------------------------------------------------------------------------------
-- Integer types
-- @section Integer

--- Get i1 type in global context
--
-- @treturn LLVMType i1
function getInt1 () end

--- Get i8 type in global context
--
-- @treturn LLVMType i8
function getInt8 () end

--- Get i16 type in global context
--
-- @treturn LLVMType i16
function getInt16 () end

--- Get i32 type in global context
--
-- @treturn LLVMType i32
function getInt32 () end

--- Get i64 type in global context
--
-- @treturn LLVMType i64
function getInt64 () end

--- Get i128 type in global context
--
-- @treturn LLVMType i128
function getInt128 () end

--- Get iN type in global context
--
-- @int N Number of bits for integer type
--
-- @treturn LLVMType iN
function getInt (N) end

--- Get int bitwidth (number of bits).
--
-- If type is not an integer type, returns 0
--
-- @treturn int Number of bits in int, or 0 if ain't integer
function getIntWidth (ty) end


--------------------------------------------------------------------------------
-- Other types
-- @section other

--- Get void type in global context
--
-- @treturn LLVMType void
function getVoid () end

--- Get label type in global context
--
-- @treturn LLVMType label
function getLabel () end

--- Get x86_mmx type in global context
--
-- @treturn LLVMType x86_mmx
function getX86MMX () end
