#include <iostream>
#include <example/lib.hpp>

int main(int argc, char *argv[])
{
    if (argc < 3)
    {
        // report version
        std::cout << argv[0] << " Version " << example_VERSION_MAJOR << "."<< example_VERSION_MINOR << std::endl;
        std::cout << "Usage: " << argv[0] << " i" << " j" << std::endl;
        return 1;
    }

    // convert input to double
    const int a = atoi(argv[1]);
    const int b = atoi(argv[2]);

    // calculate square root
    const int outputValue = add(a, b);
    std::cout << "The sum (" << a << "+" << b << ")" << " is " << outputValue << std::endl;

    // calculate square root
    const int outputValueDisplay = display();
    if (outputValueDisplay == 0) {
        std::cout << "We have created a matrix!" << std::endl;
    }
    else {
        std::cout << "We FAILED to create a matrix..." << std::endl;
    }
    
    return 0;
}
