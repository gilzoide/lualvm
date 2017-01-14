#!/usr/bin/env lua

--- This script works like the `lli` command, using a JIT Compiler
-- ExecutionEngine to run the ".ll" or ".bc" file given as first parameter.

-- input file name
local file_name = assert (arg[1], 'Please, supply an input file')

local ll = require 'lualvm'

-- Inicialize stuff needed by JIT Compiler
ll.InitializeNativeTarget ()
ll.InitializeNativeAsmPrinter ()
ll.LinkInMCJIT ()

--- Assert `created` was really created, optionaly `Dispose`ing something
local function my_assert (created, err, disposable)
	if not created then
		io.stderr:write (err .. '\n')
		if disposable then disposable:Dispose () end
		os.exit (-1)
	end
end

local _, mb, err = ll.CreateMemoryBufferWithContentsOfFile (file_name)
my_assert (mb, err)

local _, mod, err = (file_name:match '%.ll$' and ll.ParseIRInContext or ll.ParseBitcodeInContext2)
		(ll.GetGlobalContext (), mb)
my_assert (mod, err, mb)

local _, ee, err = ll.CreateJITCompilerForModule (mod, 0)
my_assert (ee, err, mod)

-- Find `main` and run it with the parameters given to this script
-- Remember: argv[0] == file_name
local main = mod:GetNamedFunction 'main'
ee:RunFunctionAsMain (main, arg, nil)
ee:Dispose ()
