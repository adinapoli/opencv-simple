
module OpenCV.Core.Tests (coreTests) where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit hiding (Test)
import OpenCV.Core


-------------------------------------------------------------------------------
coreTests :: Test
coreTests = testGroup "OpenCV.Core" [
                testCase "getNumberOfCPUs" testGetNumberOfCPUs
                , testCase "checkHardwareSupport" testCheckHardwareSupport
            ]


-------------------------------------------------------------------------------
testGetNumberOfCPUs :: Assertion
testGetNumberOfCPUs = do
  cpus <- getNumberOfCPUs
  let failMsg = "Expecting at least 1 cpu from getNumberOfCPU(s), got " ++ show cpus
  assertBool failMsg (cpus >= 1)


-------------------------------------------------------------------------------
testCheckHardwareSupport :: Assertion
testCheckHardwareSupport = do
  support <- checkHardwareSupport CvCpuNone
  let failMsg = "Expecting false from checkHardwareSupport, got " ++ show support
  assertEqual failMsg False support
