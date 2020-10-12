#!/bin/sh

mkdir build && cd build

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DOMPL_BUILD_DEMOS=OFF \
	  -G "Ninja" \
      $SRC_DIR

ninja
ninja install

# run tests
ninja test