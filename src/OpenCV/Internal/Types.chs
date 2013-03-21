{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE ExistentialQuantification #-}

module OpenCV.Internal.Types where

import Control.Lens
import Control.Lens.TH

data Point a = forall a. Num a => Point
  { _pointX :: a
  , _pointY :: a
  }

--instance Show Point where
--  show p = "<" ++ (over x show $ p) ++ "," ++ (over y show $ p) ++ ">"

