{-# LANGUAGE ForeignFunctionInterface #-}

module OpenCV.Internal.Conversions
  (asBool
  ,asCInt
  ,asCEnum) where

import Foreign
import Foreign.C.Types
import OpenCV.Internal.Types


-------------------------------------------------------------------------------
-- Potentially unsafe, we might resort on raising an exception.
asBool :: CInt -> Bool
asBool c = if (fromIntegral c == 1) then True else False


-------------------------------------------------------------------------------
asCInt :: Int -> CInt
asCInt = fromIntegral


-------------------------------------------------------------------------------
asCEnum :: (Enum a) => a -> CInt
asCEnum = fromIntegral . fromEnum
