cmake_minimum_required(VERSION 3.14.1)

project(clang_builtin_add_overflow C CXX)

set (CMAKE_CXX_STANDARD 17)

file(GLOB_RECURSE BINARY_SOURCE_FILES "src/*.cc")
foreach(BINARY_SOURCE_FILE ${BINARY_SOURCE_FILES})
  get_filename_component(BINARY_TARGET_NAME "${BINARY_SOURCE_FILE}" NAME_WE)
  add_executable(${BINARY_TARGET_NAME} "${BINARY_SOURCE_FILE}") 
endforeach()
