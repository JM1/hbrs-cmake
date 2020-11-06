# Copyright (c) 2016-2017 Jakob Meng, <jakobmeng@web.de>
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

include(FindPackageHandleStandardArgs)

find_program(GZIP NAMES gzip)

find_package_handle_standard_args(GZIP
	FOUND_VAR GZIP_FOUND
	REQUIRED_VARS GZIP
)
