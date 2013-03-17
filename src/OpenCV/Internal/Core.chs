{-# LANGUAGE ForeignFunctionInterface #-}

#include "opencvsimple_core.hpp"
#include <opencv2/core/core_c.h>

module OpenCV.Internal.Core where

import Foreign
import Foreign.C.Types

i_getNumberOfCPUs :: IO Int
i_getNumberOfCPUs = fmap fromIntegral {#call c_getNumberOfCPUs #}
