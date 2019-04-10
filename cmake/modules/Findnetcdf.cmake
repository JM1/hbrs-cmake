# Copyright (c) 2016-2019 Jakob Meng, <jakobmeng@web.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

include(FindPackageHandleStandardArgs)

if(netcdf_FIND_QUIETLY)
    set(maybe_quiet QUIET)
else()
    set(maybe_quiet)
endif()

find_package(PkgConfig ${maybe_quiet})
find_package(hdf5 ${maybe_quiet})
if(PKG_CONFIG_FOUND AND hdf5_FOUND)
	pkg_check_modules(netcdf netcdf)
	if(netcdf_FOUND)
		# replace pkg-config's hdf5 libraries with real hdf5 libraries
		list(REMOVE_ITEM netcdf_LIBRARIES hdf5 hdf5_hl)
		list(APPEND netcdf_LIBRARIES ${hdf5_LIBRARIES})
		list(APPEND netcdf_LIBRARY_DIRS ${hdf5_LIBRARY_DIRS})
	endif()
endif()

find_package_handle_standard_args(netcdf
	FOUND_VAR netcdf_FOUND
	REQUIRED_VARS netcdf_LIBRARIES netcdf_LIBRARY_DIRS netcdf_INCLUDE_DIRS netcdf_CFLAGS netcdf_VERSION
)
