#include "opencvsimple_highgui.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/highgui/highgui_c.h>

using namespace cv;

void c_namedWindow(const char* name, int flags) {
    return namedWindow(std::string(name), flags);
}

void c_destroyWindow(const char* name) {
    return destroyWindow(std::string(name));
}

CvMat* c_imread(const char* name, int flags) {
    return cvLoadImageM(name, flags);
}


void c_imshow(const char* winname, CvMat* img) {
    Mat mat(img);
    return imshow(std::string(winname), mat);
}


int c_waitKey(int delay) { return waitKey(delay); }
