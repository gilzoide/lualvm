local core = require 'lualvm.core'

-- teste do contexto
ctx = core.Context ()
mod = core.Module ('oie')

mod:setInlineAsm ('testando asm =]')
mod:clone ():dump ()

-- teste do tipo
i75 = core.type.getInt (75)
double = core.type.getDouble ()
print ('double:', double, double:getIntWidth ())
print ('label:', double.getLabel ())

-- teste do tipo função
func = core.type.Function (i75, {i75, double, double}, true)
print (func, 'return', func:getReturn (), 'paramCount', #func, 'vararg', func:isVarArg ())
for i, param in ipairs (func:getParamTypes ()) do
	print ('param ' .. i, param)
end
