#!/bin/bash

# cannot build flann from within the source directory
mkdir build
cd build

CUDA="OFF"
if [ "$cuda_impl" == "cuda" ]; then
    CUDA="ON"
    # build with c++11
    export CXXFLAGS=$(echo $CXXFLAGS | sed "s/-std=c++[0-9][0-9]/-std=c++11/")
fi

cmake -G "Ninja" \
	 -DCMAKE_INSTALL_PREFIX=$PREFIX \
	 -DBUILD_MATLAB_BINDINGS:BOOL=OFF \
	 -DBUILD_PYTHON_BINDINGS:BOOL=ON \
	 -DBUILD_EXAMPLES:BOOL=OFF \
	 -DBUILD_DOC:BOOL=OFF \
	 -DBUILD_CUDA_LIB:BOOL=$CUDA \
	 ..

ninja install
