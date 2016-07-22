local core = require 'lualvm.core'

-- teste do contexto
ctx = core.Context ()
print ("Metatable do Contexto ", getmetatable (ctx))
print (ctx)

-- teste do módulo
mod = core.Module ('oie')
print ("Metatable do Module ", getmetatable (mod), '\n')
print ("global module:dump ()")
mod:dump ()

mod = ctx:Module ('inCtx')
print ("\nctx print (module)")
print (mod)

print ("\nctx module clone + dump")
mod:clone ():dump ()

print ('\nmodule:getContext ()')
print (mod:getContext ())
