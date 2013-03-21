module OpenCV.HighGui
  (WindowName
  , WindowFlag(..)
  , ImageFlag(..)
  , namedWindow
  , destroyWindow
  , withWindow
  , imread
  , imshow
  , Delay
  , waitKey) where

import OpenCV.Internal.HighGui


-------------------------------------------------------------------------------
namedWindow :: WindowName -> WindowFlag -> IO ()
namedWindow = i_namedWindow


-------------------------------------------------------------------------------
destroyWindow :: WindowName -> IO ()
destroyWindow = i_destroyWindow

-------------------------------------------------------------------------------
withWindow :: WindowName -> WindowFlag -> (WindowName -> IO ()) -> IO ()
withWindow name flag f = namedWindow name flag >> f name >> destroyWindow name


-------------------------------------------------------------------------------
imread :: FilePath -> ImageFlag -> IO Image
imread = i_imread


-------------------------------------------------------------------------------
imshow :: WindowName -> Image -> IO ()
imshow = i_imshow


-------------------------------------------------------------------------------
waitKey :: Delay -> IO Int
waitKey = i_waitKey
