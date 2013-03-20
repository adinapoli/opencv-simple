#include "opencvsimple_highgui.hpp"
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/highgui/highgui_c.h>

using namespace cv;

void c_namedWindow(const char* name, int flags) {
    return namedWindow(std::string(name), flags);
}

//Just for the sake of experimenting, this will be garbage collected right away
CvMat* c_imread(const char* name, int flags) {
    //Mat tmp = imread(std::string(name), flags);
    //Mat* mat = new Mat(tmp)
    CvMat* mat = cvLoadImageM(name, flags);
    return mat;
}

void c_imshow(const char* winname, CvMat* img) {
    Mat mat(img);
    return imshow(std::string(winname), mat);
}

int c_waitKey(int delay) { return waitKey(delay); }
