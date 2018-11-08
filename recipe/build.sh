#!/bin/bash

# cannot build flann from within the source directory
mkdir build
cd build

CUDA="OFF"
if [ "$cuda_impl" == "cuda" ]; then
    CUDA="ON"
    # build with c++11
    export CXXFLAGS=$(echo $CXXFLAGS | sed "s/-std=c++[0-9][0-9]//")
    export CXXFLAGS="$CXXFLAGS -std=c++11"
fi

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$PREFIX/lib/pkgconfig

cmake -G "Ninja" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX                  \
    -DCMAKE_PREFIX_PATH=$PREFIX                     \
    -DBUILD_MATLAB_BINDINGS:BOOL=OFF                \
    -DBUILD_PYTHON_BINDINGS:BOOL=ON                 \
    -DBUILD_EXAMPLES:BOOL=OFF                       \
    -DBUILD_DOC:BOOL=OFF                            \
    -DBUILD_CUDA_LIB:BOOL=$CUDA                     \
    -DCMAKE_LIBRARY_ARCHITECTURE=x86_64-linux-gnu   \
    ..

ninja install
