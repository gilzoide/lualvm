local core = require 'lualvm.core'

-- teste do contexto
ctx = core.Context ()
mod = core.Module ('oie')

mod:setInlineAsm ('testando asm =]')
mod:clone ():dump ()

-- teste do tipo
void = core.type.getInt (75)
print ('void:', void, void:getIntWidth ())
print ('label:', void.getLabel ())
