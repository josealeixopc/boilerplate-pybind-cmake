#include <pybind11/pybind11.h>
#include <example/lib.hpp>

PYBIND11_MODULE(bindings, m)
{
    m.doc() = "pybind11 example plugin"; // optional module docstring

    m.def("add", &add, "A function which adds two numbers");
}