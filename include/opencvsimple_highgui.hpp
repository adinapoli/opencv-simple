#ifndef __OPENCVSIMPLE_HIGHGUI__
#define __OPENCVSIMPLE_HIGHGUI__

#include <opencv2/highgui/highgui.hpp>

#ifdef __cplusplus
extern "C" {
#endif

void c_namedWindow(const char* name, int flags);
CvMat* c_imread(const char* filename, int flags);

#ifdef __cplusplus
}
#endif

#endif
