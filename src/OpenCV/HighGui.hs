module OpenCV.HighGui
  (WindowName
  , WindowFlag(..)
  , ImageFlag(..)
  , namedWindow
  , withWindow
  , imread
  , imshow) where

import OpenCV.Internal.HighGui


-------------------------------------------------------------------------------
namedWindow :: WindowName -> WindowFlag -> IO ()
namedWindow = i_namedWindow


-------------------------------------------------------------------------------
withWindow :: WindowName -> WindowFlag -> (WindowName -> IO ()) -> IO ()
withWindow name flag f = namedWindow "name" flag >> f name


-------------------------------------------------------------------------------
imread :: FilePath -> ImageFlag -> IO Image
imread = i_imread


-------------------------------------------------------------------------------
imshow :: WindowName -> Image -> IO ()
imshow = i_imshow
