#!/bin/sh
set -x

mkdir build && cd build

# python dependencies
pip install -vU https://github.com/CastXML/pygccxml/archive/develop.zip pyplusplus
# castxml
wget -q -O- https://data.kitware.com/api/v1/file/5e8b740d2660cbefba944189/download | tar zxf - -C ${HOME}
export PATH=${HOME}/castxml/bin:${PATH}


cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DOMPL_BUILD_DEMOS=OFF \
    -DPYTHON_EXEC=${PYTHON}\
      $SRC_DIR

VERBOSE=1 make -j${CPU_COUNT}
make install

# run tests
make test
