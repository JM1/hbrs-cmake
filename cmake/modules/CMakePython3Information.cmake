# Copyright (c) 2020 Jakob Meng, <jakobmeng@web.de>
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

# This file sets the basic flags for the Python3 compiler
if(NOT CMAKE_Python3_COMPILE_OBJECT)
    set(CMAKE_Python3_COMPILE_OBJECT
        "<CMAKE_Python3_COMPILER> '${CMAKE_CURRENT_LIST_DIR}/CMakePython3CompileObject.py' \
        '<SOURCE>' \
        '<OBJECT>' \
        '${PROJECT_SOURCE_DIR}' \
        '${PROJECT_BINARY_DIR}' \
        '${CMAKE_Python3_OUTPUT_EXTENSION}' \
        '${CMAKE_VERBOSE_MAKEFILE}'")
endif()

set(CMAKE_Python3_INFORMATION_LOADED 1)
