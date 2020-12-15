# Mentioning headers (.h or .hpp files) in 'add_library()' does not affect the 'add_library()' function.
# However, they won't show in IDE's unless they are listed in 'add_library()'.
# To make it easier, we gather all .h files in a list.
set(HEADER_LIST 
    "${example_SOURCE_DIR}/include/example/lib.hpp")

# Add a library with as a target name with 'lib'
# The 'add_library' does not add an existing library. Instead, it creates (adds) a new one.
add_library(lib STATIC lib.cpp ${HEADER_LIST})

# configure a header file to pass some of the CMake settings to the source code
# 'configure_file()' copies an <input> file to an <output> file and substitutes variable values referenced as @VAR@ or ${VAR} in the input file content.
configure_file(
    ${PROJECT_SOURCE_DIR}/include/example/cmake/version.h.in
    ${PROJECT_BINARY_DIR}/cmake/version.h
    )

# 'target_include_directories()' specifies a directory or target to use (include) when compiling a target.
# We need the 'include' directory, and users of the library will need it too
# We will also need the binary dir, because the 'configure_file' generates the files that end up there.
target_include_directories(lib PUBLIC "../include" ${PROJECT_BINARY_DIR})

find_package(OpenCV REQUIRED)
target_link_libraries(lib PUBLIC ${OpenCV_LIBS})
target_include_directories(lib PUBLIC ${OpenCV_INCLUDE_DIRS})

# IDEs should put the headers in a nice place
source_group(
  TREE "${PROJECT_SOURCE_DIR}/include"
  PREFIX "Header Files"
  FILES ${HEADER_LIST})
