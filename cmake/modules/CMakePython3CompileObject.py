#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:set fileformat=unix shiftwidth=4 softtabstop=4 expandtab:
# kate: end-of-line unix; space-indent on; indent-width 4; remove-trailing-spaces modified;
# Copyright (c) 2020 Jakob Meng, <jakobmeng@web.de>

import flake8.main.application
import os
import py_compile
import shutil
import sys


def main():
    SOURCE = sys.argv[1]
    OBJECT = sys.argv[2]
    PROJECT_SOURCE_DIR = sys.argv[3]
    PROJECT_BINARY_DIR = sys.argv[4]
    OUTPUT_EXTENSION = sys.argv[5]
    VERBOSE = True if sys.argv[6] == 'ON' else False

    abs_obj = os.path.join(PROJECT_BINARY_DIR, OBJECT)
    abs_src = os.path.join(PROJECT_BINARY_DIR, SOURCE)
    rel_src = os.path.relpath(abs_src, PROJECT_SOURCE_DIR)
    abs_src_in_build = os.path.join(PROJECT_BINARY_DIR, rel_src)
    rel_src_base, _ = os.path.splitext(rel_src)
    abs_bin = os.path.join(PROJECT_BINARY_DIR, rel_src_base + OUTPUT_EXTENSION)
    if VERBOSE:
        print("Running Flake8 on '%s'" % abs_src)

    app = flake8.main.application.Application()
    app.run([abs_src])
    if (app.result_count > 0) or app.catastrophic_failure:
        raise SystemExit(True)

    if not os.path.exists(abs_src_in_build) or not os.path.samefile(abs_src, abs_src_in_build):
        # Both are same e.g. when testing the compiler
        if VERBOSE:
            print("Copying source '%s' to build directory at '%s'" % (abs_src, abs_src_in_build))

        shutil.copyfile(abs_src, abs_src_in_build)

    if VERBOSE:
        print("Compiling '%s' to '%s'" % (abs_src, abs_obj))
    py_compile.compile(SOURCE, cfile=OBJECT)

    if os.path.exists(abs_bin):
        if VERBOSE:
            print("Deleting previous build file '%s'" % abs_bin)
        os.remove(abs_bin)

    if VERBOSE:
        print("Creating hardlink from '%s' to '%s'" % (abs_obj, abs_bin))
    os.link(abs_obj, abs_bin)


if __name__ == '__main__':
    main()
