mkdir build && cd build

cmake "${CMAKE_ARGS}" \
    	-DCMAKE_INSTALL_PREFIX="$PREFIX" \
    	-DCMAKE_BUILD_TYPE=Release \
    	-DCMAKE_INSTALL_LIBDIR=lib \
    	-DOMPL_BUILD_PYBINDINGS=ON \
    	-DOMPL_BUILD_DEMOS=OFF \
    	-DOMPL_REGISTRATION=OFF \
    	-DPYTHON_EXEC="$PYTHON" \
    	-DBOOST_ROOT="$PREFIX" \
    	-G "Ninja" \
	$SRC_DIR

ninja
ninja install
# ninja update_bindings  ## ninja: error: unknown target 'update_bindings' ##
