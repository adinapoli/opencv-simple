{-# LANGUAGE ForeignFunctionInterface #-}

#include "opencvsimple_highgui.hpp"
#include <opencv2/highgui/highgui_c.h>

module OpenCV.Internal.HighGui (
  CvWindowFlag(..)
  , i_namedWindow) where

import Foreign
import Foreign.C.Types
import Foreign.C.String
import OpenCV.Internal.Conversions

data CvWindowFlag = CvWindowAutosize deriving (Eq, Show)

instance Enum CvWindowFlag where
    fromEnum CvWindowAutosize  = 0x00000001

i_namedWindow :: String -> CvWindowFlag -> IO ()
i_namedWindow n f = withCString n $ \name -> do
  {# call c_namedWindow #} name (asCEnum f)


