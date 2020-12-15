# Building PyBind11 bindings with CMake (see https://pybind11.readthedocs.io/en/latest/compiling.html#building-with-cmake)
add_subdirectory(pybind11)

# This is a wrapper of the 'add_library' function from CMake (https://cmake.org/cmake/help/v3.11/command/add_library.html)
pybind11_add_module(bindings bindings.cpp)

target_link_libraries(bindings PRIVATE lib)
