## What?

Idiomatic Haskell binding to a subset of OpenCV 2.X

## How?

Mainly c2hs and a lot of good common sense.

## Why?

* For fun
* To learn how to bind C code to Haskell
* Because I haven't found HOpenCV or CV satisfying

## Long term programs?

Well, don't make speculation. We'll see.

## Quick Taste

```haskell
import OpenCV
import Control.Monad

main :: IO ()
main = withWindow "cv" CvWindowAutosize $ \win -> do
    img <- imread "pictures/opencv.png" CvLoadImageColor
    void (imshow win img >> waitKey 0)
```

## Caveats

* In order to link your executables with ghc you need to link them
  against the C++ STD library:

  ```
  ghc -O2 -lstdc++ yourprogram.hs
  ```

* To play with the examples directly within GHCI, run it with:

 ```
 ghci -fno-ghci-sandbox
 ```
 
 This is no faultproof though, may hung your process anyway.
