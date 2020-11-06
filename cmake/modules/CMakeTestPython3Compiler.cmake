# Copyright (c) 2020 Jakob Meng, <jakobmeng@web.de>
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
# Ref.: https://github.com/Kitware/CMake/blob/master/Modules/CMakeTestCXXCompiler.cmake

if(CMAKE_Python3_COMPILER_FORCED)
  # The compiler configuration was forced by the user.
  # Assume the user has configured all compiler information.
  set(CMAKE_Python3_COMPILER_WORKS TRUE)
  return()
endif()

include(CMakeTestCompilerCommon)

unset(CMAKE_Python3_COMPILER_WORKS CACHE)

# This file is used by EnableLanguage in cmGlobalGenerator to
# determine that the selected C++ compiler can actually compile
# and link the most basic of programs.   If not, a fatal error
# is set and cmake stops processing commands and will not generate
# any makefiles or projects.

if(NOT CMAKE_Python3_COMPILER_WORKS)
  PrintTestCompilerStatus("Python3" "")
  __TestCompiler_setTryCompileTargetType()
  file(WRITE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testPython3Compiler.py "exit(0)\n")
  try_compile(CMAKE_Python3_COMPILER_WORKS ${CMAKE_BINARY_DIR}
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testPython3Compiler.py
    OUTPUT_VARIABLE __CMAKE_Python3_COMPILER_OUTPUT)
  # Move result from cache to normal variable.
  set(CMAKE_Python3_COMPILER_WORKS ${CMAKE_Python3_COMPILER_WORKS})
  unset(CMAKE_Python3_COMPILER_WORKS CACHE)
  __TestCompiler_restoreTryCompileTargetType()
  if(NOT CMAKE_Python3_COMPILER_WORKS)
    PrintTestCompilerStatus("Python3" " -- broken")
    file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
      "Determining if the Python3 compiler works failed with "
      "the following output:\n${__CMAKE_Python3_COMPILER_OUTPUT}\n\n")
    string(REPLACE "\n" "\n  " _output "${__CMAKE_Python3_COMPILER_OUTPUT}")
    message(FATAL_ERROR "The Python3 compiler\n  \"${CMAKE_Python3_COMPILER}\"\n"
      "is not able to compile a simple test program.\nIt fails "
      "with the following output:\n  ${_output}\n\n"
      "CMake will not be able to correctly generate this project.")
  endif()
  PrintTestCompilerStatus("Python3" " -- works")
  file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
    "Determining if the Python3 compiler works passed with "
    "the following output:\n${__CMAKE_Python3_COMPILER_OUTPUT}\n\n")
endif()
