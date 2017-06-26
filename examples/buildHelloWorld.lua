-- Script that creates a 'Hello World' program and prints it to stdout.
-- You can redirect it to a file, and then run with `lli` or `lli_like.lua`
local ll = require 'lualvm'

local M = ll.LLVMModule.Create 'HelloWorld'

local i32 = ll.Int32Type ()
local i8p = ll.Int8Type ():Pointer (0)

-- declare `puts`
local puts_ty = ll.FunctionType (i32, { i8p })
local puts = M:AddFunction ('puts', puts_ty)
-- puts:GetParam (0):AddAttribute (ll.ReadOnlyAttribute + ll.NoCaptureAttribute)

-- declare and build `main`
local main_ty = ll.FunctionType (i32, { i32, i8p:Pointer (0) })
local main = M:AddFunction ('main', main_ty)
local entry = main:AppendBasicBlock 'entry'
local B = ll.LLVMBuilder.Create ()
B:PositionAtEnd (entry)
local hello_str = B:GlobalStringPtr ('Hello World!', 'main.str')
B:Call (puts, { M:AddAlias (i8p, hello_str, 'oi?') }, '_'):SetTailCall (true)

B:Ret (ll.ConstInt (i32, 0))



print (M)

B:Dispose ()
M:Dispose ()
