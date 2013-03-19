#include "opencvsimple_highgui.hpp"
#include <opencv2/highgui/highgui.hpp>

void c_namedWindow(const char* name, int flags) {
    return cv::namedWindow(std::string(name), flags);
}

//Just for the sake of experimenting, this will be garbage collected right away
CvMat* c_imread(const char* name, int flags) {
    CvMat mat = cv::imread(std::string(name), flags);
    return &mat;
}
