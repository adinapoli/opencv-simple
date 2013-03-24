
module OpenCV.HighGui.Tests (guiTests) where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit hiding (Test)
import OpenCV.HighGui
import OpenCV.Unsafe.HighGui
import Data.Maybe

-------------------------------------------------------------------------------
guiTests :: Test
guiTests = testGroup "OpenCV.HighGui" [
                testCase "imgread success" testImgreadSuccess,
                testCase "imgread failure" testImgreadFail
           ]


-------------------------------------------------------------------------------
testImgreadSuccess :: Assertion
testImgreadSuccess = let failMsg = "Expected a valid img, got Nothing."
                     in assertBool failMsg (isJust (imread "examples/pictures/opencv.png" CvLoadImageColor))


-------------------------------------------------------------------------------
testImgreadFail :: Assertion
testImgreadFail = let failMsg = "Expected an invalid img, got a Just."
                     in assertBool failMsg (isNothing (imread "foo.png" CvLoadImageColor))
