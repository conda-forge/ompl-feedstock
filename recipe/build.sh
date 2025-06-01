#!/bin/sh

mkdir build && cd build

cmake ${CMAKE_ARGS} \
	  -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DOMPL_BUILD_DEMOS=OFF \
	  -G "Ninja" \
      $SRC_DIR

ninja -C build update_bindings
cmake --build build
ninja -C build install
cd py-bindings || exit
$PYTHON setup.py install
cd ..


if [[ "${target_platform}" == osx-* ]]; then
  # This is a workaround for https://github.com/conda-forge/ompl-feedstock/issues/43,
  # check the discussion there for more details
  export CTEST_DISABLED_TESTS="test_planner_data"
else
  export CTEST_DISABLED_TESTS=""
fi

if [[ "$target_platform" != "linux-aarch64" && "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
	# run tests, currently failing on arm64 for some reason
	ctest --progress --output-on-failure -E "${CTEST_DISABLED_TESTS}"
fi
