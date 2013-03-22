module OpenCV.Internal.Types 
  (Point) where

data Point a = Point2D a a | Point3D a a a deriving (Eq, Show)

point2D :: (Num a) => a -> a -> Point a
point2D = Point2D


point3D :: (Num a) => a -> a -> a -> Point a
point3D = Point3D
