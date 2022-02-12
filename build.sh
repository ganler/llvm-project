mkdir -p build && cd build
cmake   -DCMAKE_CXX_COMPILER=clang++     \
		-DCMAKE_C_COMPILER=clang         \
		-DCMAKE_BUILD_TYPE=MinSizeRel    \
		-DLLVM_BUILD_LLVM_DYLIB=ON       \
		-DLLVM_TARGETS_TO_BUILD="host" \
		-DLLVM_ENABLE_ASSERTIONS=ON    \
		-DLLVM_INCLUDE_TESTS=OFF       \
		-DLLVM_BUILD_TOOLS=ON         \
		-DLLVM_BUILD_DOCS=OFF          \
		-DLLVM_INCLUDE_EXAMPLES=OFF    \
		-DLLVM_INCLUDE_BENCHMARKS=OFF  \
		-DLLVM_ENABLE_PROJECTS="clang" \
		-Wno-dev -G Ninja ../llvm
