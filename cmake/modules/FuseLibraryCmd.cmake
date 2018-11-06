# Copyright (c) 2016-2018 Jakob Meng, <jakobmeng@web.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

set(FUSE_LIBRARY_MISSING_ARGS)
foreach(REQ_OPT IN ITEMS DESTINATION TEMPLATE HEADERS)
	if(NOT FUSE_LIBRARY_${REQ_OPT})
		list(APPEND FUSE_LIBRARY_MISSING_ARGS ${REQ_OPT})
	endif()
endforeach()
if(FUSE_LIBRARY_MISSING_ARGS)
	message(FATAL_ERROR "FUSE_LIBRARY misses argument(s): ${FUSE_LIBRARY_MISSING_ARGS}")
endif()

set(IMPL_PP_PREFIX "${FUSE_LIBRARY_PP_PREFIX}")

foreach(_FILE IN LISTS FUSE_LIBRARY_HEADERS)
	set(IMPL_INCLUDES)
	list(LENGTH FUSE_LIBRARY_DIRECTORIES FUSE_LIBRARY_DIRECTORIES_LENGTH)
	math(EXPR FUSE_LIBRARY_DIRECTORIES_RANGE "${FUSE_LIBRARY_DIRECTORIES_LENGTH} / 2 - 1")
	
	foreach(_IDX RANGE ${FUSE_LIBRARY_DIRECTORIES_RANGE})
		math(EXPR _IDX1 "2*${_IDX}+0")
		math(EXPR _IDX2 "2*${_IDX}+1")
		list(GET FUSE_LIBRARY_DIRECTORIES ${_IDX1} _DIR)
		list(GET FUSE_LIBRARY_DIRECTORIES ${_IDX2} _INCLUDE_PREFIX)
		
		if(EXISTS "${_DIR}/${_FILE}")
			set(IMPL_INCLUDE "${_INCLUDE_PREFIX}/${_FILE}")
			if(IS_ABSOLUTE "${IMPL_INCLUDE}")
				set(IMPL_INCLUDES "${IMPL_INCLUDES}\n#include \"${IMPL_INCLUDE}\"")
			else()
				set(IMPL_INCLUDES "${IMPL_INCLUDES}\n#include <${IMPL_INCLUDE}>")
			endif()
		endif()
	endforeach()
	
	get_filename_component(_FILE_WE "${_FILE}" NAME_WE)
	get_filename_component(_DIR "${_FILE}" DIRECTORY)
	if (_DIR STREQUAL "")
		set(IMPL_HDR_NAME "${_FILE_WE}")
	else()
		set(IMPL_HDR_NAME "${_DIR}/${_FILE_WE}")
	endif()
	string(REPLACE "/" "_" IMPL_HDR_NAME "${IMPL_HDR_NAME}")
	# NOTE: "\" is not a valid file or directory name on Windows, so it is save to assume it is only used as a directory separator!
	# Ref.: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365247(v=vs.85).aspx
	string(REPLACE "\\" "_" IMPL_HDR_NAME "${IMPL_HDR_NAME}")
	string(TOUPPER "${IMPL_HDR_NAME}" IMPL_HDR_NAME)
	
	
	set(IMPL_DEFINES)
	set(IMPL_TAGS)
	foreach(_TAG IN LISTS FUSE_LIBRARY_TAGS)
		set(IMPL_DEFINES "${IMPL_DEFINES}\n#ifndef ${_TAG}_${IMPL_HDR_NAME}_IMPLS          \n\t#define ${_TAG}_${IMPL_HDR_NAME}_IMPLS          ${FUSE_LIBRARY_PP_PREFIX}_${IMPL_HDR_NAME}_NULL_IMPL\n#endif")
		set(IMPL_TAGS          "${IMPL_TAGS}         (${_TAG}_${IMPL_HDR_NAME}_IMPLS)")
	endforeach()
	
	configure_file("${FUSE_LIBRARY_TEMPLATE}"  "${FUSE_LIBRARY_DESTINATION}/${_FILE}" @ONLY)
endforeach()
