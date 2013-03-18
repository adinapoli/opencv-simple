
module OpenCV.Core (
  CvFeature(..)
  , getNumberOfCPUs
  , checkHardwareSupport ) where

import OpenCV.Internal.Core

getNumberOfCPUs :: IO Int
getNumberOfCPUs = i_getNumberOfCPUs

checkHardwareSupport :: CvFeature -> IO Bool
checkHardwareSupport = i_checkHardwareSupport
