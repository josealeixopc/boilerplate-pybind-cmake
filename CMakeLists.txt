# 'cmake_mininum_required()' is a command/function that takes a keyword argument "VERSION"
# (see https://cmake.org/cmake/help/latest/command/cmake_minimum_required.html)
cmake_minimum_required(VERSION 3.10)

# set the project name and version
# the first argument of 'project()' is a positional argument (see https://cmake.org/cmake/help/latest/command/project.html)
project(example VERSION 1.0
                DESCRIPTION "Example project")

# specify the C++ standard
# 'set()' lets you set a normal variable to a given value (it also allows ENV variables -- check docs).
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
# This adds the "-fPIC" flag to the compiler. For more info about fPIC: https://stackoverflow.com/questions/966960/what-does-fpic-mean-when-building-a-shared-library
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
# This does not let CMake build shared libraries, only static
set(BUILD_SHARED_LIBS OFF)


# docs only available if doxygen is installed
find_package(Doxygen)
if(Doxygen_FOUND)
    add_subdirectory(docs)
else()
    message(STATUS "Doxygen not found, so docs won't be generated.")
endif()

# add library code
add_subdirectory(src)

# add application code
add_subdirectory(app)

# add python bindings
add_subdirectory(python)