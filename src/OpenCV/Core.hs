
module OpenCV.Core where

import OpenCV.Internal.Core

getNumberOfCPUs :: IO Int
getNumberOfCPUs = i_getNumberOfCPUs
