## Lualvm CMake ##
cmake_minimum_required (VERSION 2.8)

project (lualvm)

# Include extra cmake modules
set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

# First, find required packages
find_package (SWIG REQUIRED)
include (${SWIG_USE_FILE})
find_package (Lua REQUIRED)
find_package (LLVM REQUIRED)

# then run the src/ CMake script
add_subdirectory (src)
