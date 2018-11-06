# Copyright (c) 2016-2017 Jakob Meng, <jakobmeng@web.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

include(FindPackageHandleStandardArgs)

find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
	foreach(lib hdf5-mpich hdf5-openmpi hdf5-serial)
		pkg_check_modules(hdf5 ${lib})
		if(hdf5_FOUND)
			# make absolute library paths
			set(rlibs)
			foreach(rlib ${hdf5_LIBRARIES})
				find_library(${rlib}_path ${rlib} PATHS ${hdf5_LIBRARY_DIRS})
				if(${rlib}_path)
					list(APPEND rlibs ${${rlib}_path})
				endif()
			endforeach()
			set(hdf5_LIBRARIES ${rlibs})
			break()
		endif()
	endforeach()
endif()

find_package_handle_standard_args(hdf5
	FOUND_VAR hdf5_FOUND
	REQUIRED_VARS hdf5_LIBRARIES hdf5_LIBRARY_DIRS hdf5_INCLUDE_DIRS hdf5_CFLAGS hdf5_VERSION
)

