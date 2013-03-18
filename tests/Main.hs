import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit hiding (Test)

import OpenCV.Core.Tests

main :: IO ()
main = defaultMain [tests]

tests :: Test
tests = mutuallyExclusive $ testGroup "OpenCV" [coreTests]
