#include "opencvsimple_highgui.hpp"
#include <opencv2/highgui/highgui.hpp>

void c_namedWindow(const char* name, int flags) {
    return cv::namedWindow(std::string(name), flags);
}
