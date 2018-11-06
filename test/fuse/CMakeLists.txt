# Copyright (c) 2016-2018 Jakob Meng, <jakobmeng@web.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#

#################### fuse ####################

include(FuseLibrary)

add_library(fuse_lib INTERFACE)

fuse_library(fuse_lib
    PP_PREFIX "HBRS_CMAKE_TEST"
    DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/fused")

list_fuse_headers(fuse_headers
    FILTER "*.hpp"
    PATH "${CMAKE_CURRENT_SOURCE_DIR}/decl")

target_fuse_headers(fuse_lib ${fuse_headers})

#################### test_lib ####################

add_library(test_lib STATIC
    impl/fnc.cpp)

target_include_directories(test_lib
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
    PUBLIC ${CMAKE_CURRENT_BINARY_DIR})

target_include_directories(test_lib
    SYSTEM
    PUBLIC ${Boost_INCLUDE_DIRS})

target_link_libraries(test_lib ${Boost_LIBRARIES} fuse_lib)

target_fuse_tags(fuse_lib "HBRS_CMAKE_TEST_FUSE_IMPL")

target_fuse_directories(fuse_lib "${CMAKE_CURRENT_SOURCE_DIR}/impl" INCLUDE_PREFIX "impl")

target_link_libraries(fuse_lib INTERFACE test_lib)

############## tests ##############

get_filename_component(_pwd "${CMAKE_CURRENT_LIST_DIR}" NAME)
add_custom_target(_${_pwd}_tests)

foreach(target fuse)
    hbrs_cmake_add_test(${target})
    target_link_libraries(${target} fuse_lib)
    add_dependencies(_${_pwd}_tests ${target})
endforeach()
