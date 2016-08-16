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


--------------------------------------------------------------------------------
-- Integer types methods
-- @section Integer

--- Get int bitwidth (number of bits).
--
-- If type is not an integer type, returns 0
--
-- @treturn int Number of bits in the int type
--
-- @raise If type ain't an Integer type
function getIntWidth (ty) end


--------------------------------------------------------------------------------
-- Function types methods
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

--- Get function's parameter count
--
-- @Type ty Type
--
-- @treturn int Number of parameters
--
-- @raise If type ain't a Function type
function countParams (ty) end

--- Get a table with the function's parameter types
--
-- @Type ty Type
--
-- @treturn table Parameter types
--
-- @raise If type ain't a Function type
function getParamTypes (ty) end


--------------------------------------------------------------------------------
-- Struct types methods
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

--- Get Struct's element count
--
-- @Type ty Type
--
-- @treturn integer Element count
--
-- @raise If type ain't a Struct type
function countElements (ty) end

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
