{-# LANGUAGE ForeignFunctionInterface #-}

#include "opencvsimple_highgui.hpp"
#include <opencv2/highgui/highgui_c.h>

module OpenCV.Internal.HighGui (
  WindowName
  , WindowFlag(..)
  , Image
  , ImageFlag(..)
  , i_namedWindow
  , i_destroyWindow
  , i_imread
  , i_unsafeImread
  , i_imshow
  , Delay
  , i_waitKey) where

import Foreign hiding (unsafePerformIO)
import System.IO.Unsafe
import Foreign.Ptr
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
type Delay = Int

-------------------------------------------------------------------------------
{#pointer *CvMat as Image newtype #}

-------------------------------------------------------------------------------
i_namedWindow :: WindowName -> WindowFlag -> IO ()
i_namedWindow n f = withCString n $ \name -> do
  {# call c_namedWindow #} name (asCEnum f)


-------------------------------------------------------------------------------
i_destroyWindow :: WindowName -> IO ()
i_destroyWindow n = withCString n $ \name -> {# call c_destroyWindow #} name


-------------------------------------------------------------------------------
i_unsafeImread :: FilePath -> ImageFlag -> IO Image
i_unsafeImread n f = withCString n $ \name -> do
  {# call c_imread #} name (asCEnum f)


-------------------------------------------------------------------------------
i_imread :: FilePath -> ImageFlag -> Maybe Image
i_imread n f = let img = unsafePerformIO (i_unsafeImread n f)
                 in handlePtr img
  where handlePtr (Image i) = if (i == nullPtr) then Nothing else Just (Image i)


-------------------------------------------------------------------------------
i_imshow :: WindowName -> Image -> IO ()
i_imshow n i = withCString n $ \name -> do
  {# call c_imshow #} name i


-------------------------------------------------------------------------------
i_waitKey :: Delay -> IO Int
i_waitKey d = fmap fromIntegral $ {# call c_waitKey #} (asCInt d)
