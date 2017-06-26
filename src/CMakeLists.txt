# set inclua's compile flags 
set (INCLUA_OUTPUT_DIRECTORY ${CMAKE_PROJECT_NAME})
set (INCLUA_INCLUDE_DIRECTORIES ${LLVM_INCLUDE_DIRS})

set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g")

# LLVM bindings (for now, only core)
inclua_add_module (llvm lua llvm.yml)
inclua_link_libraries (llvm ${LLVM_LIBRARIES})

# Copy Lua files
file (GLOB luaSrc lua/*.lua)
file (COPY ${luaSrc} DESTINATION ${CMAKE_PROJECT_NAME})

##  Install  ##
set (LUA_VER "${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}")

# Variables expected from Luarocks, set if not present
# TODO: use the right path on Windows (using Luarocks is preferred anyway, so no much worries here)
if (NOT LIBDIR)
	set (LIBDIR lib/lua/${LUA_VER})
endif ()
if (NOT LUADIR)
	set (LUADIR share/lua/${LUA_VER})
endif ()

install (TARGETS llvm
	LIBRARY DESTINATION ${LIBDIR}/${CMAKE_PROJECT_NAME})
install (FILES ${luaSrc}
	DESTINATION ${LUADIR}/${CMAKE_PROJECT_NAME})
