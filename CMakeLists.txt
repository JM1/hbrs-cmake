# Copyright (c) 2018 Jakob Meng, <jakobmeng@web.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

#################### project settings ####################

project(hbrs-cmake VERSION 2018.0.0.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

include(FeatureSummary)

#################### options ####################

option(HBRS_CMAKE_ENABLE_TESTS "Build unit tests." ON)

#################### find all used packages ####################

# NOTE: Keep list of packages in sync with dependencies in *-cmake.in!

# Hana is part of boost since 1.61, Ref.: http://www.boost.org/users/history/
# BOOST_TEST macro requires 1.59, Ref.: https://stackoverflow.com/a/38083784/6490710
find_package(Boost 1.61 REQUIRED COMPONENTS unit_test_framework system thread)
set_package_properties(Boost PROPERTIES
    PURPOSE "Required for meta programming, unit tests and others."
    TYPE REQUIRED
)

#################### source settings ####################

# put the include dirs which are in the source or build tree before all other include dirs, so the headers in the sources are preferred over the already installed ones
set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)
# Src: kdelibs/cmake/modules/KDE4Defaults.cmake

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
# C++14 is required e.g. because of decltype(auto) as return type and constexpr std::forward_as_tuple()!
# C++17 is required for constexpr lambdas

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# "CMake will generate tests only if the enable_testing() command has been invoked." [1]
# "Note that ctest expects to find a test file in the build directory root. Therefore, this command should be in the 
#  source directory root." [2]
# References:
# [1] https://cmake.org/cmake/help/latest/command/add_test.html#command:add_test
# [2] https://cmake.org/cmake/help/latest/command/enable_testing.html
if(HBRS_CMAKE_ENABLE_TESTS)
    enable_testing()
endif()

#################### build settings ####################

include(MaybeAddFlags)
maybe_add_c_flag  (HBRS_CMAKE_HAS_C_WALL                         "-Wall")
maybe_add_cxx_flag(HBRS_CMAKE_HAS_CXX_WALL                       "-Wall")
#maybe_add_c_flag  (HBRS_CMAKE_HAS_C_WEXTRA                       "-Wextra")
#maybe_add_cxx_flag(HBRS_CMAKE_HAS_CXX_WEXTRA                     "-Wextra")
maybe_add_c_flag  (HBRS_CMAKE_HAS_C_WPEDANTIC                    "-Wpedantic")
maybe_add_cxx_flag(HBRS_CMAKE_HAS_CXX_WPEDANTIC                  "-Wpedantic")
maybe_add_c_flag  (HBRS_CMAKE_HAS_C_WERROR_RETURN_TYPE           "-Werror=return-type")
maybe_add_cxx_flag(HBRS_CMAKE_HAS_CXX_WERROR_RETURN_TYPE         "-Werror=return-type")
maybe_add_c_flag  (HBRS_CMAKE_HAS_C_PEDANTIC_ERRORS              "-pedantic-errors")
maybe_add_cxx_flag(HBRS_CMAKE_HAS_CXX_PEDANTIC_ERRORS            "-pedantic-errors")

#################### install settings ####################

include(GNUInstallDirs)
# Src.: http://www.cmake.org/cmake/help/v2.8.8/cmake.html#module:GNUInstallDirs

# Offer a choice of overriding the installation directories
set(HBRS_CMAKE_INSTALL_LIBDIR      ${CMAKE_INSTALL_LIBDIR}                                     CACHE PATH "install dir for libraries")
set(HBRS_CMAKE_INSTALL_CMAKEDIR    ${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}         CACHE PATH "install dir for CMake files")
set(HBRS_CMAKE_INSTALL_CMAKEMODDIR ${CMAKE_INSTALL_LIBDIR}/cmake/${CMAKE_PROJECT_NAME}/modules CACHE PATH "install dir for CMake modules")

#################### list the subdirectories ####################

add_subdirectory(cmake)
add_subdirectory(test)

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
