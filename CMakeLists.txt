# Copyright (c) 2018 Jakob Meng, <jakobmeng@web.de>
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

#################### project settings ####################

project(hbrs-cmake VERSION 2018.0.0.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

include(FeatureSummary)

#################### source settings ####################

# put the include dirs which are in the source or build tree before all other include dirs, so the headers in the sources are preferred over the already installed ones
set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)
# Src: kdelibs/cmake/modules/KDE4Defaults.cmake

#################### install settings ####################

include(GNUInstallDirs)
# Src.: http://www.cmake.org/cmake/help/v2.8.8/cmake.html#module:GNUInstallDirs

# Offer a choice of overriding the installation directories
set(HBRS_CMAKE_INSTALL_LIBDIR      ${CMAKE_INSTALL_LIBDIR}                                     CACHE PATH "install dir for libraries")
set(HBRS_CMAKE_INSTALL_CMAKEDIR    ${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}         CACHE PATH "install dir for CMake files")
set(HBRS_CMAKE_INSTALL_CMAKEMODDIR ${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}/modules CACHE PATH "install dir for CMake modules")

#################### list the subdirectories ####################

add_subdirectory(cmake)

#################### install files ####################

include(CMakePackageConfigHelpers)
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/hbrs-cmake-config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/hbrs-cmake-config.cmake"
    INSTALL_DESTINATION "${HBRS_CMAKE_INSTALL_CMAKEDIR}"
    PATH_VARS
        HBRS_CMAKE_INSTALL_LIBDIR
        HBRS_CMAKE_INSTALL_CMAKEDIR
        HBRS_CMAKE_INSTALL_CMAKEMODDIR)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/hbrs-cmake-config-version.cmake"
    VERSION ${hbrs-cmake_VERSION}
    COMPATIBILITY AnyNewerVersion)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/hbrs-cmake-config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/hbrs-cmake-config-version.cmake"
    DESTINATION ${HBRS_CMAKE_INSTALL_CMAKEDIR}
    COMPONENT development)

#################### summary ####################

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
