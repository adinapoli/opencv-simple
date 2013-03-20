{-# LANGUAGE ForeignFunctionInterface #-}

#include "opencvsimple_highgui.hpp"
#include <opencv2/highgui/highgui_c.h>

module OpenCV.Internal.HighGui (
  WindowName
  , WindowFlag(..)
  , Image
  , ImageFlag(..)
  , i_namedWindow
  , i_imread
  , i_imshow) where

import Foreign
import Foreign.C.Types
import Foreign.C.String
import OpenCV.Internal.Conversions


-------------------------------------------------------------------------------
data WindowFlag = CvWindowAutosize deriving (Eq, Show)

instance Enum WindowFlag where
  fromEnum CvWindowAutosize  = 1


data ImageFlag = CvLoadImageColor deriving (Eq, Show)

instance Enum ImageFlag where
  fromEnum CvLoadImageColor = 1


-------------------------------------------------------------------------------
type WindowName = String


-------------------------------------------------------------------------------
{#pointer *CvMat as Image newtype #}


-------------------------------------------------------------------------------
i_namedWindow :: WindowName -> WindowFlag -> IO ()
i_namedWindow n f = withCString n $ \name -> do
  {# call c_namedWindow #} name (asCEnum f)


-------------------------------------------------------------------------------
i_imread :: FilePath -> ImageFlag -> IO Image
i_imread n f = withCString n $ \name -> do
  {# call c_imread #} name (asCEnum f)


-------------------------------------------------------------------------------
i_imshow :: WindowName -> Image -> IO ()
i_imshow n i = withCString n $ \name -> do
  {# call c_imshow #} name i
