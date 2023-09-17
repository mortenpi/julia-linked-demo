JULIA_VERSION=julia-1.9.3
JULIA_TARBALL=${JULIA_VERSION}-linux-x86_64.tar.gz
JULIA_BINARY_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.9/${JULIA_TARBALL}

all: julia-binary/${JULIA_VERSION} hello-julia-cc/hello-julia

julia-binary/${JULIA_TARBALL}:
	curl --output "julia-binary/${JULIA_TARBALL}" ${JULIA_BINARY_URL}
	cd julia-binary/ && sha256sum -c ${JULIA_VERSION}.sha256

julia-binary/${JULIA_VERSION}/: julia-binary/${JULIA_TARBALL}
	tar -C julia-binary/ -xf julia-binary/${JULIA_TARBALL}

# The C/C++ program

hello-julia-cc/hello-julia: hello-julia-cc/hello-julia.cc
	${CXX} -o $@ $?

.PHONY: hello-julia-cc-test
hello-julia-cc-test: hello-julia-cc/hello-julia
	hello-julia-cc/hello-julia ${PWD}/julia-binary/${JULIA_VERSION}/lib/libjulia.so
