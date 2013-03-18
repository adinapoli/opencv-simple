{-# LANGUAGE ForeignFunctionInterface #-}

#include "opencvsimple_core.hpp"
#include <opencv2/core/core_c.h>

module OpenCV.Internal.Core 
  (i_getNumberOfCPUs,
   CvFeature(..),
   i_checkHardwareSupport) where

import Foreign
import Foreign.C.Types

asBool :: CInt -> Bool
asBool c = case fromIntegral c of
  1 -> True
  _ -> False

asCInt :: Int -> CInt
asCInt = fromIntegral
  

i_getNumberOfCPUs :: IO Int
i_getNumberOfCPUs = fmap fromIntegral {#call c_getNumberOfCPUs #}

-- OpenCV doesn't use an ENUM for the features, so we can't use c2hs goodness
data CvFeature = CvCpuNone  | CvCpuMmx   | CvCpuSse    | CvCpuSse2 | CvCpuSsse3 |
                 CvCpuSse41 | CvCpuSse42 | CvCpuPopcnt | CvCpuAvx  | CvCpuSse3  |
                 CvHardwareMaxFeature deriving (Eq, Show)

instance Enum CvFeature where
    fromEnum CvCpuNone            = 0
    fromEnum CvCpuMmx             = 1
    fromEnum CvCpuSse             = 2
    fromEnum CvCpuSse2            = 3
    fromEnum CvCpuSse3            = 4
    fromEnum CvCpuSsse3           = 5
    fromEnum CvCpuSse41           = 6
    fromEnum CvCpuSse42           = 7
    fromEnum CvCpuPopcnt          = 8
    fromEnum CvCpuAvx             = 10
    fromEnum CvHardwareMaxFeature = 255

i_checkHardwareSupport :: CvFeature -> IO Bool
i_checkHardwareSupport f = fmap asBool $ {#call c_checkHardwareSupport #} (asCInt . fromEnum $ f)
