#ifndef __OPENCVSIMPLE_HIGHGUI__
#define __OPENCVSIMPLE_HIGHGUI__

#include <opencv2/highgui/highgui_c.h>

#ifdef __cplusplus
extern "C" {
#endif

void c_namedWindow(const char* name, int flags);
void c_destroyWindow(const char* name);
CvMat* c_imread(const char* filename, int flags);
void c_imshow(const char* winname, CvMat* img);
int c_waitKey(int delay);

#ifdef __cplusplus
}
#endif

#endif
