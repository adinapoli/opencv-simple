## What?

Idiomatic Haskell binding to a subset of OpenCV 2.X

## How?

Mainly c2hs and a lot of good common sense. Lately I've been playing with the
idea of a RabbitMQ based binding. The need stems from the fact that the C
OpenCV API don't leverage the full power of the library, and they are likely
to be deprecated in the future. On the other side, Haskell doesn't allow
C++ binding: c2hs complains everytime it sees a C++ types inside an header
(try this at home). I've already had the problem of making C++ communicate with
the rest of the world, namely when I was developing [Laetus](http://laetus.sourceforge.net)
for my master degree dissertation. Back in those days the language of choice
was Erlang. Erlang uses a byte-oriented mechanism called "port", which allows
to call every foreign code; the only prerequisite is that the foreign code
stick to the "port" standard. Lately I've realised that is should be possible
to be the same using RabbitMQ, reusing some tricks I've used to bind Laetus
to Erlang.

### The main idea

The main idea boils down to allow state into our Haskell code. The following
is by no means valid Haskell code, is just an overview of how the system should
work. First of all, we have this problem; C++ has classes, and we want to be
create them as well as invoking their own methods. Every object is uniquely
identified in memory by his memory address. The latest fact is quite powerful
in its implications. What we want to achieve can be summarised by this picture:

![The idea](http://cdn.imghack.se/images/57b998421eda5aad3be50c6360295d76.png)

As should be evident from the picture, the binding consists of an intermediate
C++11 executable which is our backdoor to OpenCV. It will call the openCV C++
features like object construction, destructions, templates, etc.

### Architecture

A tentative architecture consist of the following, and is inspired from my
master degree's work:

* A ``Reactor``, which keep listening on a port for new commands. This will be
  likely implemented with a RabbitMQ queue.

* A "command/plugin" system, inspired by the respective design patterns. A
  command is a well defined, auto contained piece of functionality which we
  can pass to the ´´Reactor´´. Suppose we want to create a new OpenCV Point;
  we'll create a new C++ functions which creates the Point. Then we'll register
  this command to the reactor exposing the "point" command to the outside.
  Hopefully this will be clear with an example later.

* A ``ReferenceTable``, which keeps track of the object created. This is the
  most important class of the whole system.

#### C++ classes

On the Haskell side, every interaction with the C++ counterpart will be
regulated by handling raw pointers. Since we don't have the luxury of saying,
for example ``Ptr VideoCapture`` (because the latter is a C++ class) we'll
need to do something as ugly as:

```haskell
newtype VideoCapture = VideoCapture String
```

Where the ``String`` is the memory address of our C++ object. I'm currently
wondering if we can reuse the FFI ``Ptr a`` type but I doubt so, because we
need as ``a`` a valid C pointer, which we don't have. What happen, then, when
we want to access this ``VideoCapture``? Well, we'll send to our C++ broker
this string, which we'll be searched into the ``ReferenceTable``: the latter
associate a C++ object/ data structure with his memory address. This is the
trick which allowed me to bind Laetus to Erlang. Once we find this object we
invoke the requested method and sends back the response to Haskell. This last
statement should not be taken lightly.

### Purity and C++
Certain OpenCV functions are pure by nature, for example:

```cpp
float fastAtan2(float y, float x);
```

And the good thing is that the ```float``` type has a natural counterpart in
Haskell. But take a look at this for example:

```cpp
void blur(InputArray src, OutputArray dst, Size ksize, Point anchor=Point(-1,-1), int borderType=BORDER_DEFAULT )
```

Apart from the implicit side effect of "filling" the ```OutputArray``` with the
blurred image, if we create and maintain a C++ object we must be wary of not
modify its internal state later on! Not only this requires a strong discipline,
but is deceiving by nature. By this is a problem that we could also have with
the standard FFI interface, so nothing new here.


## Why?

* For fun
* To learn how to bind C++ code to Haskell
* Because I haven't found HOpenCV or CV satisfying

## Long term programs?

Well, don't make speculation. We'll see.

## Quick Taste

The following is implemented with c2hs, but shows a couple of interesting
things:

* We expose a 1:1 mapping between the OpenCV functions and their Haskell
  counterparts. Obviously the more C-friendly a function is, the better the
  result.

* The functions which fiddle with pointers live in the ``OpenCV.Unsafe.*`` modules,
  and have the prefix ``unsafe``. They don't give either some guarantee in terms
  of successful completion or encourage type safety. In the example below, 
  ``unsafeImread`` has signature ``unsafeImread :: FilePath -> CvImageFlag -> Image``
  where ``Image`` is just a nice name for a ``CvMat*`` pointer (notice that we
  are currently using the C data structures, this hopefully will change if I
  succeed in implementing the RabbitMQ-driven binding mechanism). Compare now
  with the safe function: ``imread :: FilePath -> CvImageFlag -> Maybe Image``

* We add combinators and sugar where possible. In the example we use the
  ``withWindow`` function which creates and destroys an OpenCV window under
  the hood.

```haskell
import OpenCV
import Control.Monad

main :: IO ()
main = withWindow "cv" CvWindowAutosize $ \win -> do
    img <- unsafeImread "pictures/opencv.png" CvLoadImageColor
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
