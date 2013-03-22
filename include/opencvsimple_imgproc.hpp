#ifndef __OPENCVSIMPLE_IMGPROC__
#define __OPENCVSIMPLE_IMGPROC__

#include <opencv2/core/types_c.h>

#ifdef __cplusplus
extern "C" {
#endif

CvMat* c_blur(CvMat* input, CvSize ksize, CvPoint anchor, int borderType);

#ifdef __cplusplus
}
#endif

#endif
