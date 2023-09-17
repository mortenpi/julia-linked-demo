# Demo of linking Julia to C/C++

Goals of this demonstration:

* Show a minimal working example of a local binary running, linking to Julia, and calling into Julia.
* Julia should be loaded dynamically at runtime, not at compile time. This is to emulate the "plugin language" use case, where you probably do not want to have a special build of your software just to enable Julia plugins.

## Getting started

In principle, running

```
make hello-julia-cc-test
```

should be enough to run the demo. This will:

* Download the Julia 1.9.3 binary and pack it.
* Compiles the `hello-julia.cc` program, which dynamically loads the Julia shared library.
* Runs that compiled program, which loads `libjulia.so` at runtime, initializes a Julia session, and then evaluates a simple Julia code example.

## Documentation

* ["Embedding Julia" in the Julia manual](https://docs.julialang.org/en/v1/manual/embedding/)
* [`dlopen` on Linux](https://man7.org/linux/man-pages/man3/dlopen.3.html)
