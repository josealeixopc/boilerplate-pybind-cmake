#ifndef LIB_H
#define LIB_H

#include "cmake/version.h"

/**
 * @brief This function displays the image in a given path.
 * 
 * @param path Path to the image.
 * @return int 0 if successful, -1 otherwise.
 */
int display();

/**
 * @brief This function sums two integers.
 * 
 * @param a 
 * @param b 
 * @return int The sum.
 */
int add(int a, int b);

#endif /* LIB_H */