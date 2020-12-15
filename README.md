# Python bindings

A simple example on how to build a C++ library for calcluations called `calc` using **CMake** and then wrapping it with Python bindings using **PyBind11**.

## References

- [CMake Tutorial](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
- [Modern CMake](https://cliutils.gitlab.io/modern-cmake/)
- [PyBind CMake Example](https://github.com/pybind/cmake_example)


## Some considerations

- `CMake` is a `Makefile` wrapper. That is, it generates Makefiles.
- A C++ project with CMake should have the following [structure](https://cliutils.gitlab.io/modern-cmake/chapters/basics/structure.html) (also available at [GitLab](https://gitlab.com/CLIUtils/modern-cmake/tree/master/examples/extended-project)).
    - The current project is an example of it.
- Bundling C++ libraries with a Python package is trivial if we have access to the **static** version of the libraries. We need only to create a shared library which includes the static versions of the dependencies and may be deployed without needing to install anything.
- However, if we only have access to the **shared** version of the libraries, the issue is more complex. As of now, I know about a few ways of circumventing this:
    - Using [`auditwheel`](https://github.com/pypa/auditwheel) to build a Wheel that includes the shared libraries by copying them and modifying the `rpath`.
    - Manually doing what `auditwheel` does, using commands such as [`ldd`](https://man7.org/linux/man-pages/man1/ldd.1.html) to find the dependencies of an executable.
    - Instead of using `rpath`, using `LD_LIBRARY_PATH` ([difference between `rpath` and `LD_LIBRARY_PATH`](https://stackoverflow.com/questions/13617137/what-is-the-difference-between-ld-library-path-and-rpath)).
    - The **easiest one** is simply providing a script for installing the dependencies, however this implies more work for the final user.

## Installing PyBind11

To add pybind11 as a submodule to the current directory, add it as a submodule. You should choose the `stable` branch of pybind11:

```
git submodule add https://github.com/pybind/pybind11 ./pybind11 -b stable
git submodule update --init
```

## Building a CMake project

```bash
mkdir build && \
cd build && \
cmake .. && \
cmake --build .
```

- The `cmake ..` command creates the necessary files and Makefiles from the `CMakeLists.txt` configuration in the parent directory.
- `cmake --build .` runs the makefiles to build the binary files.

### Generating documentation

To generate the documentation you'll need to install Doxygen, which in turn requires Flex and Bison.

```bash
sudo apt-get install flex
sudo apt-get install bison
```

Then to actually build the docs (requires Doxygen, output in build/docs/html):

```bash
cd build
cmake --build . --target docs
```

## Running in Docker

The `Dockerfile` is already built to automatically install the generated Python modules using `pip`. To verify the bindings working, run:

```bash
python
```

Then:

```python
import bindings
help(bindings)
bindings.add(1, 2)  # should output 3
bindings.display()  # should output 0, meaning OpenCV functions work (only if OpenCV library is installed or otherwise included in the Wheel)
``` 

## Acknowledgements

- Author: [José Aleixo Cruz](https://github.com/josealeixopc)