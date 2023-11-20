#!/bin/bash

echo
echo "=== BUILD ==="
echo

cmake -B debug
cmake --build debug

cmake -DCMAKE_BUILD_TYPE=Release -B release
cmake --build release

echo
echo "=== RUN ==="

for binary in ./debug/native ./debug/clang_extension ./release/native ./release/clang_extension ; do
  echo
  echo "Running '$binary'."
  $binary
done

echo
echo "=== EXAMINE ASM ==="
echo

g++ -O3 -DNDEBUG -S src/native.cc
g++ -O3 -DNDEBUG -S src/clang_extension.cc

for asm in *.s ; do
  echo
  echo "// Contents of '$asm'."
  cat $asm
done

echo
echo "=== DIFF ASMS ==="
echo
diff native.s clang_extension.s


