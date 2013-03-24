module OpenCV.Unsafe.HighGui
  (unsafeImread) where

import OpenCV.Internal.HighGui


-------------------------------------------------------------------------------
unsafeImread :: FilePath -> ImageFlag -> IO Image
unsafeImread = i_unsafeImread
