import Test.Framework (defaultMain, testGroup, Test)
import Test.Framework.Providers.HUnit

import Test.HUnit hiding (Test)

import OpenCV.Core

main = defaultMain tests

tests :: [Test]
tests = [
        testGroup "OpenCV.Core" [
                testCase "getNumberOfCPUs" testGetNumberOfCPUs
            ]
    ]


testGetNumberOfCPUs :: Assertion
testGetNumberOfCPUs = do
  cpus <- getNumberOfCPUs
  let failMsg = "Expecting at least 1 cpu from getNumberOfCPU(s), got " ++ show cpus
  assertBool failMsg (cpus >= 1)
