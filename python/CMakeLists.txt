# Building PyBind11 bindings with CMake (see https://pybind11.readthedocs.io/en/latest/compiling.html#building-with-cmake)
add_subdirectory(pybind11)

# There are two options here: SHARED and MODULE. 
# I don't know the difference, but SHARED let's the library be used in a brand new environment without the installed dependnecies.
pybind11_add_module(bindings SHARED bindings.cpp)

target_link_libraries(bindings PRIVATE lib)
