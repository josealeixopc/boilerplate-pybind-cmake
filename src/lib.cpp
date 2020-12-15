#include <stdio.h>
#include <opencv2/opencv.hpp>

int display()
{
    cv::Mat image = cv::Mat::zeros(cv::Size(10, 10),CV_8UC1);
    if ( !image.data )
    {
        return -1;
    }
    else {
        return 0;
    }
}

int add(int i, int j) {
    return i + j;
}