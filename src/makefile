## LuaLVM C++ stuff Makefile ##

# SWIG + C++ stuff
interfaceSrc = llvm.i
cppSrc = $(buildDir)/llvm.cpp
sharedObj = $(libDir)/llvm.so
llvmIncludes = $(shell llvm-config --includedir)
llvmFlags = $(shell llvm-config --cxxflags)
llvmLinks = $(shell llvm-config --system-libs --libs)

CXX = clang++
CXXFLAGS = -Wall -O2 $(llvmFlags)
LINKS = $(llvmLinks)

# Lua stuff
luaSrc = $(wildcard *.lua)

# Build #
all : interface shared lua


# and each submodule in it's module's dir
interface : $(interfaceSrc)
	swig -I$(llvmIncludes) -o $(cppSrc) -lua $<
	sed -i 's/"LLVM/"/' $(cppSrc)

shared : $(cppSrc)
	$(CXX) -o $(sharedObj) $< -shared $(CXXFLAGS) $(LINKS)

%.o : %.cpp
	$(CXX) -o $@ -c $< $(CXXFLAGS)


# and copy the ".lua" file(s)
lua : $(luaSrc)
	cp $^ $(buildDir)


.PHONY : clean
clean :
	$(RM) *~ *.o
