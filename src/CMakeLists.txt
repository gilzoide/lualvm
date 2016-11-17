# make SWIG find the headers
set (CMAKE_SWIG_FLAGS -I${LLVM_INCLUDE_DIRS})
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_PROJECT_NAME})
# make SWIG use the same type runtime for all modules
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DSWIG_TYPE_TABLE=${CMAKE_PROJECT_NAME}")

# General modules
set (modules core)
foreach (mod ${modules})
	swig_add_module (${mod} lua ${mod}.i)
	swig_link_libraries (${mod} ${LLVM_LIBRARIES})
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
