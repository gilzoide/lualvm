# set inclua's compile flags 
set (INCLUA_OUTPUT_DIRECTORY ${CMAKE_PROJECT_NAME})
set (INCLUA_INCLUDE_DIRECTORIES ${LLVM_INCLUDE_DIRS})

# LLVM bindings (for now, only core)
inclua_add_module (llvm lua llvm.yml)
inclua_link_libraries (llvm ${LLVM_LIBRARIES})

# Copy Lua files
file (GLOB luaSrc *.lua)
file (COPY ${luaSrc} DESTINATION ${CMAKE_PROJECT_NAME})

##  Install  ##
set (LUA_VER "${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}")
install (TARGETS llvm
	LIBRARY DESTINATION lib/lua/${LUA_VER}/${CMAKE_PROJECT_NAME})
install (FILES ${luaSrc}
	DESTINATION share/lua/${LUA_VER}/${CMAKE_PROJECT_NAME})
