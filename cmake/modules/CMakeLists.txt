# Copyright (c) 2018-2020 Jakob Meng, <jakobmeng@web.de>
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

install(FILES
    CMakeDeterminePython3Compiler.cmake
    CMakePython3Compiler.cmake.in
    CMakePython3Information.cmake
    CMakeTestPython3Compiler.cmake
    CMakePython3CompileObject.py
    DevTools.cmake
    FindFLAME.cmake
    Findgperftools_profiler.cmake
    FindGZIP.cmake
    Findhdf5.cmake
    FindLAPACKE.cmake
    Findmpi4py.cmake
    Findnetcdf.cmake
    Findnetcdf-cxx4.cmake
    FindOBJDUMP.cmake
    FindPERF.cmake
    FindVALGRIND.cmake
    MaybeAddFlags.cmake
    #string_replace.cmake
    DESTINATION ${HBRS_CMAKE_INSTALL_CMAKEMODDIR})
