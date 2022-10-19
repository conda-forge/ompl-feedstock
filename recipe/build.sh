#!/bin/sh

mkdir build && cd build

cmake ${CMAKE_ARGS} \
	  -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DOMPL_BUILD_DEMOS=OFF \
	  -G "Ninja" \
      $SRC_DIR

ninja
ninja install

if [[ "$target_platform" != "linux-aarch64" && "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
	# run tests, currently failing on arm64 for some reason
	ninja test
fi
