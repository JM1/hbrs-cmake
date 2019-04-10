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

if(NOT netcdf_FOUND)
	find_package(netCDF ${maybe_quiet})
	if(netCDF_FOUND)
		# Ref.: /usr/lib/x86_64-linux-gnu/cmake/netCDF/netCDFConfig.cmake
		#       from https://packages.debian.org/buster/libnetcdf-dev
		set(netcdf_LIBRARY_DIRS ${netCDF_LIB_DIR})
		set(netcdf_INCLUDE_DIRS ${netCDF_INCLUDE_DIR})
		set(netcdf_LIBRARIES ${netCDF_LIBRARIES})
		set(netcdf_CFLAGS ${netCDF_C_COMPILER_FLAGS})
		set(netcdf_VERSION ${NetCDFVersion})
		set(netcdf_FOUND TRUE)
	endif()
endif()

if(NOT netcdf_FOUND)
	find_package(PkgConfig ${maybe_quiet})
	if(PKG_CONFIG_FOUND)
		pkg_check_modules(netcdf ${maybe_quiet} netcdf)
		if(netcdf_FOUND)
			find_package(hdf5 ${maybe_quiet})
			if(hdf5_FOUND)
				# replace pkg-config's hdf5 libraries with real hdf5 libraries
				list(REMOVE_ITEM netcdf_LIBRARIES hdf5 hdf5_hl)
				list(APPEND netcdf_LIBRARIES ${hdf5_LIBRARIES})
				list(APPEND netcdf_LIBRARY_DIRS ${hdf5_LIBRARY_DIRS})
			endif()
		endif()
	endif()
endif()

find_package_handle_standard_args(netcdf
	FOUND_VAR netcdf_FOUND
	REQUIRED_VARS netcdf_LIBRARIES netcdf_LIBRARY_DIRS netcdf_VERSION
	# netcdf_INCLUDE_DIRS and netcdf_CFLAGS might not be set by pkg_check_modules(...)
	VERSION_VAR netcdf_VERSION
)
