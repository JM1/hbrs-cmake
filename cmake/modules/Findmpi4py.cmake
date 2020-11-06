# Copyright (c) 2020 Jakob Meng, <jakobmeng@web.de>
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# Ref.:
# [1] https://gitlab.kitware.com/xdmf/xdmf/-/blob/master/CMake/FindMPI4PY.cmake
# [2] https://gitlab.kitware.com/sensei/sensei/blob/master/CMake/FindMPI4PY.cmake
# [3] https://bitbucket.org/fenics-project/dolfin/src/master/python/cmake/FindMPI4PY.cmake

include(FindPackageHandleStandardArgs)

if(NOT mpi4py_FOUND)
    find_package(Python QUIET COMPONENTS Interpreter)

    execute_process(COMMAND
        "${Python_EXECUTABLE}" "-c" "import mpi4py; print(mpi4py.get_include())"
        OUTPUT_VARIABLE mpi4py_INCLUDE_DIRS
        RESULT_VARIABLE mpi4py_COMMAND_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(NOT mpi4py_COMMAND_RESULT)
        set(mpi4py_FOUND TRUE)
        set(mpi4py_INCLUDE_DIRS ${mpi4py_INCLUDE_DIRS} CACHE STRING "mpi4py include directories")
        mark_as_advanced(mpi4py_INCLUDE_DIRS)
    else()
        set(mpi4py_FOUND FALSE)
        unset(mpi4py_INCLUDE_DIRS)
    endif()

    if(mpi4py_FOUND)
        execute_process(COMMAND
            "${Python_EXECUTABLE}" "-c" "import mpi4py; print(mpi4py.__version__)"
            OUTPUT_VARIABLE mpi4py_VERSION
            RESULT_VARIABLE mpi4py_COMMAND_RESULT
            OUTPUT_STRIP_TRAILING_WHITESPACE)
        if(NOT mpi4py_COMMAND_RESULT)
            set(mpi4py_VERSION "${mpi4py_VERSION}" CACHE STRING "mpi4py version string")
            mark_as_advanced(mpi4py_VERSION)
        else()
            unset(mpi4py_VERSION)
        endif()
    endif()
endif()

if(mpi4py_FOUND AND NOT mpi4py_FIND_QUIETLY)
    message(STATUS "mpi4py_INCLUDE_DIRS=${mpi4py_INCLUDE_DIRS}")
    message(STATUS "mpi4py_VERSION=${mpi4py_VERSION}")
endif()

find_package_handle_standard_args(mpi4py DEFAULT_MSG mpi4py_INCLUDE_DIRS mpi4py_VERSION)
