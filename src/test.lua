local core = require 'lualvm.core'

-- teste do contexto
ctx = core.Context ()
mod = core.Module ('oie')

mod:setInlineAsm ('testando asm =]')
mod:clone ():dump ()

-- teste do tipo
i75 = ctx:getInt (75)
double = ctx:getDouble ()
print ('label:', ctx:getLabel ())

-- teste do tipo função
print ('\nFunction')
func = core.type.Function (i75, {i75, double, double}, true)
print (func, 'return', func:getReturn (), 'paramCount', func:countParams (), 'vararg', func:isVarArg ())
for i, param in ipairs (func:getParamTypes ()) do
	print ('param ' .. i, param)
end

-- teste do tipo struct
print ('\nStruct')
struct = ctx:NamedStruct ('oie')
struct:setBody { double }
print (struct:getName (), struct)
struct1 = ctx:Struct ({ i75, i75 }, true)
print (struct1:getName (), struct1, struct1:countElements (), 'packed', struct1:isPacked (), 'opaque', struct1:isOpaque ())

for i, elem in ipairs (struct1:getElementTypes ()) do
	print ('element ' .. i, elem)
end
print ('elem 3', struct1:getTypeAtIndex (3))
