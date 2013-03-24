## What?

Idiomatic Haskell binding to a subset of OpenCV 2.X

## How?

Mainly c2hs and a lot of good common sense. Lately I've been playing with the
idea of a RabbitMQ based binding. The need stems from the fact that the C
OpenCV API don't leaverage the full power of the library, and they are likely
to be deprecated in the future. On the other side, Haskell doesn't allow
C++ binding: c2hs complains everytime it sees a C++ types inside an header
(try this at home). I've already had the problem of making C++ communicate with
the rest of the world, namely when I was developing [Laetus](http://laetusframework.sourceforge.org)
for my master degree dissertation. Back in those days the language of choice
was Erlang. Erlang uses a byte-oriented mechanism called "port", which allows
to call every foreign code; the only prerequisite is that the foreign code
stick to the "port" standard. Lately I've realised that is should be possible
to be the same using RabbitMQ, reusing some tricks I've used to bind Laetus
to Erlang.

### The main idea

The main idea boils down to allow the state into our Haskell code. The following
is by no means valid Haskell code, is just an overview of how the system should
work. First of all, we have this problem; C++ has classes, and we want to be
create them as well as invoking their own methods. Every object is uniquely
identified in memory by his memory address. The latest fact is quite powerful
in its implications. What we want to achieve can be summarised by this picture:


![The idea](http://cdn.imghack.se/images/57b998421eda5aad3be50c6360295d76.png)

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
