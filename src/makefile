## LuaLVM C++ stuff Makefile ##

src = $(wildcard *.cpp)
objs = $(src:.cpp=.o)
libSharedObj = $(pkgName).so
llvmFlags = $(shell llvm-config --cxxflags)
llvmLinks = $(shell llvm-config --system-libs --libs core)

CXX = g++
CXXFLAGS = $(llvmFlags)

all : $(objs)
	$(CXX) -o $(buildDir)/$(libSharedObj) $^ -shared $(CXXFLAGS) $(llvmLinks)

%.o : %.cpp
	$(CXX) -o $@ -c $< $(CXXFLAGS)


.PHONY : clean
clean :
	$(RM) *~ *.o
