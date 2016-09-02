--- @module lualvm.core.type
-- [LLVM-C Type](http://www.llvm.org/docs/doxygen/html/group__LLVMCCoreType.html)
-- functions, usually accessed in Lua through the `LLVMType` methods.
--
-- Types in LLVM are always uniqued within a context, so there's always only 1
-- instance of a specific type. That said, types can be compared for equality
-- with the expected behavior.

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

--- Get type's length, available for the following only.
--
-- * Integer: `LLVMGetIntTypeWidth (ty)` - Integer bit width
-- * Function: `LLVMCountParamTypes (ty)` - Function parameter count
-- * Struct: `LLVMCountStructElementTypes (ty)` - Struct element count
-- * Array: `LLVMGetArrayLength (ty)` - Array length
-- * Vector: `LLVMGetVectorSize (ty)` - Vector size
--
-- @Type ty Type
--
-- @treturn[0] int Type length
-- @treturn[1] nil When type length doesn't fit
function __len (ty) end

--------------------------------------------------------------------------------
-- Function types
-- @section Function

--- Get a function type consisting of the specified signature
--
-- @Type returnType The return type
-- @table[opt={}] paramTypes Table with the parameter types
-- @bool[opt=false] isVarArg If function accepts variable arguments
--
-- @treturn LLVMType Function type
function Function (returnType, paramTypes, isVarArg) end

--- Get whether type `ty` is vararg
--
-- @Type ty Type
--
-- @treturn bool Accepts variable arguments?
--
-- @raise If type ain't a Function type
function isVarArg (ty) end

--- Get the function's return type
--
-- @Type ty Type
--
-- @treturn LLVMType Return type
--
-- @raise If type ain't a Function type
function getReturn (ty) end

--- Get a table with the function's parameter types
--
-- @Type ty Type
--
-- @treturn table Parameter types
--
-- @raise If type ain't a Function type
function getParamTypes (ty) end


--------------------------------------------------------------------------------
-- Struct types
-- @section Struct

--- Get Struct's name
--
-- @Type ty Type
--
-- @treturn[0] string Name
-- @treturn[1] nil For anonimous structs
--
-- @raise If type ain't a Struct type
function getName (ty) end

--- Set Struct body
--
-- @Type ty Type
-- @table[opt={}] elemTypes Table with the element types
-- @bool[opt=false] packed Should Struct be packed?
--
-- @raise If type ain't a Struct type
function setBody (ty, elemTypes, packed) end

--- Get a table with Struct's element types
--
-- @Type ty Type
--
-- @treturn table Element types
--
-- @raise If type ain't a Struct type
function getElementTypes (ty) end

--- Get type at index `idx` in Struct.
--
-- Note that as Lua, index here starts from 1
--
-- @Type ty Type
-- @int idx Index
--
-- @treturn[0] LLVMType
-- @treturn[1] nil On invalid index
--
-- @raise If type ain't a Struct type
function getTypeAtIndex (ty, idx) end

--- Is Struct packed?
--
-- @Type ty Type
--
-- @treturn bool Whether a Struct is packed
--
-- @raise If type ain't a Struct type
function isPacked (ty) end

--- Is Struct opaque?
--
-- @Type ty Type
--
-- @treturn bool Whether a Struct is opaque
--
-- @raise If type ain't a Struct type
function isOpaque (ty) end


--------------------------------------------------------------------------------
-- Sequential types
-- @section Sequential

--- Obtain the type of elements within a sequential type
--
-- @Type ty Type
--
-- @treturn LLVMType Type of the underlying elements of type `ty`
--
-- @raise If type ain't a Sequential type (Array, Pointer, Vector)
function getUnderlyingType (ty) end


--------------------------------------------------------------------------------
-- Array types
-- @section Array

--- Create a fixed size array type that refers to a specific type
--
-- @Type ty Underlying elements' type
-- @int elementCount Number of elements in Array
--
-- @treturn LLVMType Array type
function Array (ty, elementCount) end


--------------------------------------------------------------------------------
-- Pointer types
-- @section Pointer

--- Create a pointer type that points to a defined type
--
-- @Type underlyingType The underlying elements' type
-- @int[opt=0] addressSpace Address space for pointer
--
-- @treturn LLVMType Pointer type
function Pointer (underlyingType, addressSpace) end
