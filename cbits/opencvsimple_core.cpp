#include "opencvsimple_core.hpp"
#include <opencv2/core/core.hpp>

int asInt(bool b) { return (b ? 1 : 0); }
int c_getNumberOfCPUs() { return cv::getNumberOfCPUs(); }
int c_checkHardwareSupport(int feature) { return asInt(cv::checkHardwareSupport(feature)); }
