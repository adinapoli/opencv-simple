module OpenCV.HighGui
  ( CvWindowFlag(..)
  , namedWindow) where

import OpenCV.Internal.HighGui

namedWindow :: String -> CvWindowFlag -> IO ()
namedWindow = i_namedWindow
