module OpenCV.HighGui
  (WindowName
  , WindowFlag(..)
  , ImageFlag(..)
  , namedWindow
  , imread) where

import OpenCV.Internal.HighGui


-------------------------------------------------------------------------------
namedWindow :: WindowName -> WindowFlag -> IO ()
namedWindow = i_namedWindow


-------------------------------------------------------------------------------
imread :: FilePath -> ImageFlag -> IO Image
imread = i_imread
