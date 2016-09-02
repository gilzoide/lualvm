local llvm = require 'lualvm.llvm'

-- teste do contexto
ctx = llvm.ContextCreate ()
mod = llvm.ModuleCreateWithNameInContext ('teste =]', ctx)

llvm.DumpModule (mod)


llvm.DisposeModule (mod)
llvm.ContextDispose (ctx)
