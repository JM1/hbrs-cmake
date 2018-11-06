# Copyright (c) 2016-2018 Jakob Meng, <jakobmeng@web.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

include(CMakeParseArguments)
set(__MACRO_FUSE_LIBRARY_LIST_DIR ${CMAKE_CURRENT_LIST_DIR})

function(TARGET_FUSE_TAGS TARGET)
	set_property(TARGET ${TARGET} APPEND PROPERTY INTERFACE_FUSE_TAGS ${ARGN})
endfunction()

function(TARGET_FUSE_HEADERS TARGET)
	set_property(TARGET ${TARGET} APPEND PROPERTY INTERFACE_FUSE_HEADERS ${ARGN})
endfunction()

function(TARGET_FUSE_DIRECTORIES TARGET)
	set(options)
	set(oneValueArgs INCLUDE_PREFIX)
	set(multiValueArgs)
	cmake_parse_arguments(TARGET_FUSE_DIRECTORIES "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
	
	set(TARGET_FUSE_DIRECTORIES_MISSING_ARGS)
	foreach(REQ_OPT IN ITEMS INCLUDE_PREFIX)
		if(NOT TARGET_FUSE_DIRECTORIES_${REQ_OPT})
			list(APPEND TARGET_FUSE_DIRECTORIES_MISSING_ARGS ${REQ_OPT})
		endif()
	endforeach()
	if(TARGET_FUSE_DIRECTORIES_MISSING_ARGS)
		message(FATAL_ERROR "TARGET_FUSE_DIRECTORIES misses argument(s): ${TARGET_FUSE_DIRECTORIES_MISSING_ARGS}")
	endif()
	
	foreach(_DIR IN LISTS TARGET_FUSE_DIRECTORIES_UNPARSED_ARGUMENTS)
		get_filename_component(_PATH "${_DIR}" ABSOLUTE)
		set_property(TARGET ${TARGET} APPEND PROPERTY INTERFACE_FUSE_DIRECTORIES "${_PATH}")
		set_property(TARGET ${TARGET} APPEND PROPERTY INTERFACE_FUSE_DIRECTORIES "${TARGET_FUSE_DIRECTORIES_INCLUDE_PREFIX}")
	endforeach()
endfunction()

function(LIST_FUSE_HEADERS LISTNAME)
	set(options)
	set(oneValueArgs)
	set(multiValueArgs FILTER PATH)
	cmake_parse_arguments(LIST_HEADERS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
	
	set(_LIST PARENT_SCOPE)
	foreach(_DIR IN LISTS LIST_HEADERS_PATH)
		if(LIST_HEADERS_FILTER)
			file(GLOB_RECURSE _PATHS RELATIVE "${_DIR}" "${_DIR}/${LIST_HEADERS_FILTER}")
		else()
			file(GLOB_RECURSE _PATHS RELATIVE "${_DIR}" "${_DIR}/*.hpp" "${_DIR}/*.h" "${_DIR}/*.hh")
		endif()
		
		foreach(_PATH IN LISTS _PATHS)
			if(NOT IS_DIRECTORY ${_PATH})
				list(APPEND _LIST ${_PATH})
			endif()
		endforeach()
	endforeach()
	
	if(_LIST)
		list(REMOVE_DUPLICATES _LIST)
	endif()
	
	set(${LISTNAME} "${_LIST}" PARENT_SCOPE)
endfunction()

function(FUSE_LIBRARY TARGET)
	set(options)
	set(oneValueArgs DESTINATION TEMPLATE PP_PREFIX)
	set(multiValueArgs)
	cmake_parse_arguments(FUSE_LIBRARY "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

	set(FUSE_LIBRARY_MISSING_ARGS)
	foreach(REQ_OPT IN ITEMS DESTINATION)
		if(NOT FUSE_LIBRARY_${REQ_OPT})
			list(APPEND FUSE_LIBRARY_MISSING_ARGS ${REQ_OPT})
		endif()
	endforeach()
	if(FUSE_LIBRARY_MISSING_ARGS)
		message(FATAL_ERROR "FUSE_LIBRARY misses argument(s): ${FUSE_LIBRARY_MISSING_ARGS}")
	endif()
	
	if(NOT FUSE_LIBRARY_TEMPLATE)
        set(FUSE_LIBRARY_TEMPLATE "${__MACRO_FUSE_LIBRARY_LIST_DIR}/FuseLibraryImpl.hpp.in")
	endif()
	
	add_custom_target(${TARGET}_fuse
		VERBATIM
		COMMAND ${CMAKE_COMMAND}
			-D FUSE_LIBRARY_TAGS=$<TARGET_PROPERTY:${TARGET},INTERFACE_FUSE_TAGS>
			-D FUSE_LIBRARY_DIRECTORIES=$<TARGET_PROPERTY:${TARGET},INTERFACE_FUSE_DIRECTORIES>
			-D FUSE_LIBRARY_HEADERS=$<TARGET_PROPERTY:${TARGET},INTERFACE_FUSE_HEADERS>
			-D FUSE_LIBRARY_DESTINATION=${FUSE_LIBRARY_DESTINATION}
			-D FUSE_LIBRARY_TEMPLATE=${FUSE_LIBRARY_TEMPLATE}
			-D FUSE_LIBRARY_PP_PREFIX=${FUSE_LIBRARY_PP_PREFIX}
			-P "${__MACRO_FUSE_LIBRARY_LIST_DIR}/FuseLibraryCmd.cmake"
	)
	add_dependencies(${TARGET} ${TARGET}_fuse)
endfunction()
