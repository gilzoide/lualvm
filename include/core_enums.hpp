/* lualvm, a Lua wrapper for the LLVM-C API
 * Copyright (C) 2016 gilzoide
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Any bugs should be reported to <gilzoide@gmail.com>
 */

/** @file core_enums.hpp
 * LLVM core types and enumerations
 */
#pragma once

#include <lua.hpp>
#include <llvm-c/Core.h>


/**
 * Register all core enums into table at index `index`
 *
 * @param L Lua state
 */
void registerCoreEnums (lua_State *L) {
	// index of table where enums will be registered
	auto table = lua_gettop (L);

/// Macro to insert a enum value into the table at top of the stack
#define insertEnum(str, val) \
	lua_pushinteger (L, val); \
	lua_setfield (L, -2, str)

/// As default, everything in LLVM-C is prefixed by "LLVM", so use it!
#define insertLLVMEnum(e) \
	insertEnum (#e, LLVM ## e)

	//--  Attributes  --//
	lua_newtable (L);
/// specific enum inserter for the Attribute Enum
#define insertAttribute(e) \
	insertEnum (#e, LLVM ## e ## Attribute)

	insertAttribute (ZExt);
	insertAttribute (SExt);
	insertAttribute (NoReturn);
	insertAttribute (InReg);
	insertAttribute (StructRet);
	insertAttribute (NoUnwind);
	insertAttribute (NoAlias);
	insertAttribute (ByVal);
	insertAttribute (Nest);
	insertAttribute (ReadNone);
	insertAttribute (ReadOnly);
	insertAttribute (NoInline);
	insertAttribute (AlwaysInline);
	insertAttribute (OptimizeForSize);
	insertAttribute (StackProtect);
	insertAttribute (StackProtectReq);
	insertLLVMEnum (Alignment);
	insertAttribute (NoCapture);
	insertAttribute (NoRedZone);
	insertAttribute (NoImplicitFloat);
	insertAttribute (Naked);
	insertAttribute (InlineHint);
	insertLLVMEnum (StackAlignment);
	insertLLVMEnum (ReturnsTwice);
	insertLLVMEnum (UWTable);
	insertLLVMEnum (NonLazyBind);

	lua_setfield (L, table, "Attribute");
#undef insertAttribute

	//--  Opcode  --//
	lua_newtable (L);
	insertLLVMEnum (Ret);
	insertLLVMEnum (Br);
	insertLLVMEnum (Switch);
	insertLLVMEnum (IndirectBr);
	insertLLVMEnum (Invoke);
	insertLLVMEnum (Unreachable);
	insertLLVMEnum (Add);
	insertLLVMEnum (FAdd);
	insertLLVMEnum (Sub);
	insertLLVMEnum (FSub);
	insertLLVMEnum (Mul);
	insertLLVMEnum (FMul);
	insertLLVMEnum (UDiv);
	insertLLVMEnum (SDiv);
	insertLLVMEnum (FDiv);
	insertLLVMEnum (URem);
	insertLLVMEnum (SRem);
	insertLLVMEnum (FRem);
	insertLLVMEnum (Shl);
	insertLLVMEnum (LShr);
	insertLLVMEnum (AShr);
	insertLLVMEnum (And);
	insertLLVMEnum (Or);
	insertLLVMEnum (Xor);
	insertLLVMEnum (Alloca);
	insertLLVMEnum (Load);
	insertLLVMEnum (Store);
	insertLLVMEnum (GetElementPtr);
	insertLLVMEnum (Trunc);
	insertLLVMEnum (ZExt);
	insertLLVMEnum (SExt);
	insertLLVMEnum (FPToUI);
	insertLLVMEnum (FPToSI);
	insertLLVMEnum (UIToFP);
	insertLLVMEnum (SIToFP);
	insertLLVMEnum (FPTrunc);
	insertLLVMEnum (FPExt);
	insertLLVMEnum (PtrToInt);
	insertLLVMEnum (IntToPtr);
	insertLLVMEnum (BitCast);
	insertLLVMEnum (AddrSpaceCast);
	insertLLVMEnum (ICmp);
	insertLLVMEnum (FCmp);
	insertLLVMEnum (PHI);
	insertLLVMEnum (Call);
	insertLLVMEnum (Select);
	insertLLVMEnum (UserOp1);
	insertLLVMEnum (UserOp2);
	insertLLVMEnum (VAArg);
	insertLLVMEnum (ExtractElement);
	insertLLVMEnum (InsertElement);
	insertLLVMEnum (ShuffleVector);
	insertLLVMEnum (ExtractValue);
	insertLLVMEnum (InsertValue);
	insertLLVMEnum (Fence);
	insertLLVMEnum (AtomicCmpXchg);
	insertLLVMEnum (AtomicRMW);
	insertLLVMEnum (Resume);
	insertLLVMEnum (LandingPad);
	insertLLVMEnum (CleanupRet);
	insertLLVMEnum (CatchRet);
	insertLLVMEnum (CatchPad);
	insertLLVMEnum (CleanupPad);
	insertLLVMEnum (CatchSwitch);

	lua_setfield (L, table, "Opcode");

	//--  TypeKind  --//
	lua_newtable (L);
/// specific enum inserter for the TypeKind Enum
#define insertTypeKind(t) \
	insertEnum (#t, LLVM ## t ## TypeKind)

	insertTypeKind (Void);
	insertTypeKind (Half);
	insertTypeKind (Float);
	insertTypeKind (Double);
	insertTypeKind (X86_FP80);
	insertTypeKind (FP128);
	insertTypeKind (PPC_FP128);
	insertTypeKind (Label);
	insertTypeKind (Integer);
	insertTypeKind (Function);
	insertTypeKind (Struct);
	insertTypeKind (Array);
	insertTypeKind (Pointer);
	insertTypeKind (Vector);
	insertTypeKind (Metadata);
	insertTypeKind (X86_MMX);
	insertTypeKind (Token);

	lua_setfield (L, table, "TypeKind");
#undef insertTypeKind

	//--  Linkage  --//
	lua_newtable (L);
/// specific enum inserter for the Linkage Enum
#define insertLinkage(l) \
	insertEnum (#l, LLVM ## l ## Linkage)

	insertLinkage (External);
	insertLinkage (AvailableExternally);
	insertLinkage (LinkOnceAny);
	insertLinkage (LinkOnceODR);
	insertLinkage (LinkOnceODRAutoHide);
	insertLinkage (WeakAny);
	insertLinkage (WeakODR);
	insertLinkage (Appending);
	insertLinkage (Internal);
	insertLinkage (Private);
	insertLinkage (DLLImport);
	insertLinkage (DLLExport);
	insertLinkage (ExternalWeak);
	insertLinkage (Ghost);
	insertLinkage (Common);
	insertLinkage (LinkerPrivate);
	insertLinkage (LinkerPrivateWeak);

	lua_setfield (L, table, "Linkage");
#undef insertLinkage

	//--  Visibility  --//
	lua_newtable (L);
/// specific enum inserter for the Visibility Enum
#define insertVisibility(v) \
	insertEnum (#v, LLVM ## v ## Visibility)

	insertVisibility (Default);
	insertVisibility (Hidden);
	insertVisibility (Protected);

	lua_setfield (L, table, "Visibility");
#undef insertVisibility

	//--  DLLStorageClass  --//
	lua_newtable (L);
/// specific enum inserter for the DLLStorageClass Enum
#define insertDLLStorageClass(sc) \
	insertEnum (#sc, LLVM ## sc ## StorageClass)

	insertDLLStorageClass (Default);
	insertDLLStorageClass (DLLImport);
	insertDLLStorageClass (DLLExport);

	lua_setfield (L, table, "DLLStorageClass");
#undef insertDLLStorageClass

	//--  CallConv  --//
	lua_newtable (L);
/// specific enum inserter for the CallConv Enum
#define insertCallConv(cc) \
	insertEnum (#cc, LLVM ## cc ## CallConv)

	insertCallConv (C);
	insertCallConv (Fast);
	insertCallConv (Cold);
	insertCallConv (WebKitJS);
	insertCallConv (AnyReg);
	insertCallConv (X86Stdcall);
	insertCallConv (X86Fastcall);

	lua_setfield (L, table, "CallConv");
#undef insertCallConv

	//--  IntPredicate  --//
	lua_newtable (L);
/// specific enum inserter for the IntPredicate Enum
#define insertIntPredicate(ip) \
	insertEnum (#ip, LLVMInt ## ip)

	insertIntPredicate (EQ);
	insertIntPredicate (NE);
	insertIntPredicate (UGT);
	insertIntPredicate (UGE);
	insertIntPredicate (ULT);
	insertIntPredicate (ULE);
	insertIntPredicate (SGT);
	insertIntPredicate (SGE);
	insertIntPredicate (SLT);
	insertIntPredicate (SLE);

	lua_setfield (L, table, "IntPredicate");
#undef insertIntPredicate

	//--  RealPredicate  --//
	lua_newtable (L);
/// specific enum inserter for the RealPredicate Enum
#define insertRealPredicate(rp) \
	insertEnum (#rp, LLVMReal ## rp)

	insertRealPredicate (PredicateFalse);
	insertRealPredicate (OEQ);
	insertRealPredicate (OGT);
	insertRealPredicate (OGE);
	insertRealPredicate (OLT);
	insertRealPredicate (OLE);
	insertRealPredicate (ONE);
	insertRealPredicate (ORD);
	insertRealPredicate (UNO);
	insertRealPredicate (UEQ);
	insertRealPredicate (UGT);
	insertRealPredicate (UGE);
	insertRealPredicate (ULT);
	insertRealPredicate (ULE);
	insertRealPredicate (UNE);
	insertRealPredicate (PredicateTrue);

	lua_setfield (L, table, "RealPredicate");
#undef insertIntPredicate

	//--  LandingPadClauseTy  --//
	lua_newtable (L);
/// specific enum inserter for the LandingPadClauseTy Enum
#define insertLandingPadClauseTy(lp) \
	insertEnum (#lp, LLVMLandingPad ## lp)

	insertLandingPadClauseTy (Catch);
	insertLandingPadClauseTy (Filter);

	lua_setfield (L, table, "LandingPadClauseTy");
#undef insertLandingPadClauseTy

	//--  ThreadLocalMode  --//
	lua_newtable (L);
/// specific enum inserter for the ThreadLocalMode Enum
#define insertThreadLocalMode(tl) \
	insertEnum (#tl, LLVM ## tl ## TLSModel)

	insertLLVMEnum (NotThreadLocal);
	insertThreadLocalMode (GeneralDynamic);
	insertThreadLocalMode (LocalDynamic);
	insertThreadLocalMode (InitialExec);
	insertThreadLocalMode (LocalExec);

	lua_setfield (L, table, "ThreadLocalMode");
#undef insertThreadLocalMode

	//--  AtomicOrdering  --//
	lua_newtable (L);
/// specific enum inserter for the AtomicOrdering Enum
#define insertAtomicOrdering(ao) \
	insertEnum (#ao, LLVMAtomicOrdering ## ao)

	insertAtomicOrdering (NotAtomic);
	insertAtomicOrdering (Unordered);
	insertAtomicOrdering (Monotonic);
	insertAtomicOrdering (Acquire);
	insertAtomicOrdering (Release);
	insertAtomicOrdering (AcquireRelease);
	insertAtomicOrdering (SequentiallyConsistent);

	lua_setfield (L, table, "AtomicOrdering");
#undef insertAtomicOrdering

	//--  AtomicRMWBinOp  --//
	lua_newtable (L);
/// specific enum inserter for the AtomicRMWBinOp Enum
#define insertAtomicRMWBinOp(armw) \
	insertEnum (#armw, LLVMAtomicRMWBinOp ## armw)

	insertAtomicRMWBinOp (Xchg);
	insertAtomicRMWBinOp (Add);
	insertAtomicRMWBinOp (Sub);
	insertAtomicRMWBinOp (And);
	insertAtomicRMWBinOp (Nand);
	insertAtomicRMWBinOp (Or);
	insertAtomicRMWBinOp (Xor);
	insertAtomicRMWBinOp (Max);
	insertAtomicRMWBinOp (Min);
	insertAtomicRMWBinOp (UMax);
	insertAtomicRMWBinOp (UMin);

	lua_setfield (L, table, "AtomicRMWBinOp");
#undef insertAtomicRMWBinOp

	//--  DiagnosticSeverity  --//
	lua_newtable (L);
/// specific enum inserter for the DiagnosticSeverity Enum
#define insertDiagnosticSeverity(ds) \
	insertEnum (#ds, LLVMDS ## ds)

	insertDiagnosticSeverity (Error);
	insertDiagnosticSeverity (Warning);
	insertDiagnosticSeverity (Remark);
	insertDiagnosticSeverity (Note);

	lua_setfield (L, table, "DiagnosticSeverity");
#undef insertDiagnosticSeverity

#undef insertLLVMEnum
	
#undef insertEnum
}

