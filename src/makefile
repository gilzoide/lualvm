## LuaLVM C++ stuff Makefile ##

# C++ stuff
src = $(wildcard *.cpp)
objs = $(src:.cpp=.so)
llvmFlags = $(shell llvm-config --cxxflags)
llvmLinks = $(shell llvm-config --system-libs --libs)

CXX = g++
CXXFLAGS = -Wall -O2 -I$(includeDir) $(llvmFlags)
LINKS = $(llvmLinks)

# Lua stuff
luaSrc = $(wildcard *.lua)

# Build #
all : $(objs) lua


# build each cpp file as a shared object
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
