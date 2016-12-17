# make SWIG find the headers
set (INCLUA_OUTPUT_DIRECTORY ${CMAKE_PROJECT_NAME})

# General modules
set (modules core)
foreach (mod ${modules})
	inclua_add_module (${mod} lua ${mod}.yml -I${LLVM_INCLUDE_DIRS})
	inclua_link_libraries (${mod} ${LLVM_LIBRARIES})
endforeach (mod)

# Copy Lua files
file (GLOB luaSrc *.lua)
file (COPY ${luaSrc} DESTINATION ${CMAKE_PROJECT_NAME})

##  Install  ##
set (LUA_VER "${LUA_VERSION_MAJOR}.${LUA_VERSION_MINOR}")
install (TARGETS ${modules}
	LIBRARY DESTINATION lib/lua/${LUA_VER}/${CMAKE_PROJECT_NAME})
install (FILES ${luaSrc}
	DESTINATION share/lua/${LUA_VER}/${CMAKE_PROJECT_NAME})
