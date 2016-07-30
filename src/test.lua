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

assert (mod:toFile ('/mod'))

print ('\nmodule:getContext ()')
print (mod:getContext ())

print ('\nmodule:getDataLayout ()')
mod:setDataLayout ('e-m:o-p:32:32-f64:32:64-v64:32:64-v128:32:128-a:0:32-n32-S32')
print (mod:getDataLayout (), '\n')

print ('\nmodule:getTarget ()')
mod:setTarget ()
print (mod:getTarget (), '\n')

-- Core enums
function printaTanto (nome)
	local totalEnums = 0
	for _ in pairs (core[nome]) do totalEnums = totalEnums + 1 end
	print (nome, totalEnums .. ' campos')
end
printaTanto ('Attribute')
printaTanto ('Opcode')
printaTanto ('TypeKind')
printaTanto ('Linkage')
printaTanto ('Visibility')
printaTanto ('DLLStorageClass')
printaTanto ('CallConv')
printaTanto ('IntPredicate')
printaTanto ('RealPredicate')
printaTanto ('LandingPadClauseTy')
printaTanto ('ThreadLocalMode')
printaTanto ('AtomicOrdering')
printaTanto ('AtomicRMWBinOp')
printaTanto ('DiagnosticSeverity')
