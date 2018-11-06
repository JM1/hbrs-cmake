# Copyright (c) 2016-2017 Jakob Meng, <jakobmeng@web.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

include(FindPackageHandleStandardArgs)

find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
	pkg_check_modules(netcdf-cxx4 netcdf-cxx4)
endif()

find_package_handle_standard_args(netcdf-cxx4
	FOUND_VAR netcdf-cxx4_FOUND
	REQUIRED_VARS netcdf-cxx4_LIBRARIES netcdf-cxx4_CFLAGS netcdf-cxx4_VERSION
)
