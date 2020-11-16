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

## Building

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

To add pybind11 as a submodule to the current directory, add it as a submodule. You should choose the `stable` branch of pybind11:

```
git submodule add https://github.com/pybind/pybind11 ./pybind11 -b stable
git submodule update --init
```

The `Dockerfile` is already built to automatically install the generated Python modules using `pip`. To verify the bindings working, run:

```bash
python
```

Then:

```python
import bindings
help(bindings)
bindings.add(1, 2)  # should output 3
``` 