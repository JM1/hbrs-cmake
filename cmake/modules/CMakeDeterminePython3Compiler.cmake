# Copyright (c) 2020 Jakob Meng, <jakobmeng@web.de>
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
# Python3 Linter and Bytecode Compiler
#
# Inspired by CMakeDetermine*Compiler.cmake scripts in [1] and example given in [2].
#
# Ref.:
# [1] https://github.com/Kitware/CMake/tree/master/Modules
# [2] https://stackoverflow.com/questions/38293535/generic-rule-from-makefile-to-cmake/38296922#38296922

find_package(Python3 QUIET REQUIRED)

set(CMAKE_Python3_COMPILER "${Python3_EXECUTABLE}")
mark_as_advanced(CMAKE_Python3_COMPILER)

set(CMAKE_Python3_COMPILER_ENV_VAR "Python3")

# Configure variables set in this file for fast reload later on
configure_file("${CMAKE_CURRENT_LIST_DIR}/CMakePython3Compiler.cmake.in"
               "${CMAKE_PLATFORM_INFO_DIR}/CMakePython3Compiler.cmake" @ONLY)
