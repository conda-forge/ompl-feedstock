#!/bin/sh
set -ex

mkdir build && cd build

# python dependencies
pip install -vU https://github.com/CastXML/pygccxml/archive/develop.zip
pip install https://files.pythonhosted.org/packages/aa/ed/445b49e7ce743e314b4fc631c25aec366f11837cf451a5417feefede4196/pyplusplus-1.8.3-py3-none-any.whl

# castxml
wget -q -O- https://data.kitware.com/api/v1/file/5e8b740d2660cbefba944189/download | tar zxf - -C ${HOME}
export PATH=${HOME}/castxml/bin:${PATH}


cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
	  -DCMAKE_BUILD_TYPE=Release \
	  -DCMAKE_INSTALL_LIBDIR=lib \
	  -DOMPL_BUILD_DEMOS=OFF \
          -D OMPL_BUILD_PYBINDINGS:BOOL=ON \
      $SRC_DIR

VERBOSE=1 make -j${CPU_COUNT}
make install

# run tests
make test
