## LuaLVM C++ stuff Makefile ##

# C++ stuff
src = $(wildcard *.cpp) $(foreach m, $(modules), $(wildcard $m/*.cpp))
objs = $(src:.cpp=.so)
llvmFlags = $(shell llvm-config --cxxflags)
llvmLinks = $(shell llvm-config --system-libs --libs)

CXX = clang++
CXXFLAGS = -Wall -O2 -I$(includeDir) $(llvmFlags)
LINKS = $(llvmLinks)

# Lua stuff
luaSrc = $(wildcard *.lua)

# Build #
all : $(objs) lua


# and each submodule in it's module's dir
%.so : %.o
	$(CXX) -o $(libDir)/$@ $< -shared $(CXXFLAGS) $(LINKS)

%.o : %.cpp
	$(CXX) -o $@ -c $< $(CXXFLAGS)


# and copy the ".lua" file(s)
lua : $(luaSrc)
	cp $^ $(buildDir)


.PHONY : clean
clean :
	$(RM) *~ *.o
