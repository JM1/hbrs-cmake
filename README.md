# CMake package `hbrs-cmake` feat. additional modules and scripts for CMake

`hbrs-cmake` ([GitHub.com][hbrs-cmake], [H-BRS GitLab][hbrs-gitlab-hbrs-cmake]) is [CMake 3][cmake3-tut] package that
provides additional modules and scripts for CMake, e.g. to find common software using CMake's `find_package()`, such as
[`FLAME`][flame], [`gzip`][wiki-gzip], [`LAPACKE`][lapacke], [`objdump`][wiki-objdump], [`perf`][wiki-perf],
[`valgrind`][valgrind], [`hdf5`][wiki-hdf], [`mpi4py`][mpi4py-ref] and [`netcdf`][netcdf].

Its development started in 2015 as a research project at [Bonn-Rhein-Sieg University of Applied Sciences][hbrs],
from 2016-2019 it was funded partly by BMBF project [AErOmAt][aeromat].

Primary use cases for `hbrs-cmake` are:
* [`hbrs-mpl`][hbrs-mpl] ([GitHub.com][hbrs-mpl], [H-BRS GitLab][hbrs-gitlab-hbrs-mpl]),
  a generic [C++17][wiki-cpp17] library for distributed scientific computing at HPC clusters
* [`hbrs-theta_utils`][hbrs-theta-utils] ([GitHub.com][hbrs-theta-utils], [H-BRS GitLab][hbrs-gitlab-hbrs-theta-utils]),
  a postprocessing tool to CFD solvers [TAU and THETA][tau] for data-driven modal decompositions
* [`python-edamer`][py-edamer] ([GitHub.com][py-edamer], [H-BRS GitLab][hbrs-gitlab-py-edamer]),
  a Python 3 library for exascale data analysis and machine learning applications

:warning: **WARNING:**
This code is still under development and is not ready for production yet.
Code might change or break at any time and is missing proper documentation.
:warning:

## How to build, install and run code using `Docker` or `Podman`

For a quick and easy start into developing with C++, a set of ready-to-use `Docker`/`Podman` images
`jm1337/debian-dev-hbrs` and `jm1337/debian-dev-full` (supports more languages) has been created. They contain a full
development system including all tools and libraries necessary to hack on distributed decomposition algorithms and more
([Docker Hub][docker-hub-jm1337], [source files for Docker images][docker-artifacts]).

### Install `Docker` or `Podman`

* On `Debian 10 (Buster)` or `Debian 11 (Bullseye)` just run `sudo apt install docker.io`
  or follow the [official install guide][docker-install-debian] for Docker Engine on Debian
* On `Ubuntu 18.04 LTS (Bionic Beaver)` and `Ubuntu 20.04 LTS (Focal Fossa)` just run `sudo apt install docker.io`
  (from `bionic/universe` and `focal/universe` repositories)
  or follow the [official install guide][docker-install-ubuntu] for Docker Engine on Ubuntu
* On `Windows 10` follow the [official install guide][docker-install-windows] for Docker Desktop on Windows
* On `Mac` follow the [official install guide][docker-install-mac] for Docker Desktop on Mac
* On `Fedora`, `Red Hat Enterprise Linux (RHEL)` and `CentOS` follow the [official install guide][podman-install] for
  Podman

### Setup and run container

```sh
# docker version 18.06.0-ce or later is recommended
docker --version

# fetch docker image
docker pull jm1337/debian-dev-hbrs:bullseye

# log into docker container
docker run -ti jm1337/debian-dev-hbrs:bullseye
# or using a persistent home directory, e.g.
docker run -ti -v /HOST_DIR:/home/devil/ jm1337/debian-dev-hbrs:bullseye
# or using a persistent home directory on Windows hosts, e.g.
docker run -ti -v C:\YOUR_DIR:/home/devil/ jm1337/debian-dev-hbrs:bullseye
```

Podman strives for complete CLI compatibility with Docker, hence
[you may use the `alias` command to create a `docker` alias for Podman][docker-to-podman-transition]:
```sh
alias docker=podman
```

### Build and run code inside container

Execute the following commands within the `Docker`/`Podman` container:

```sh
# fetch, compile and install hbrs-cmake
git clone --depth 1 https://github.com/JM1/hbrs-cmake.git
cd hbrs-cmake
mkdir build && cd build/
# install to non-system directory because sudo is not allowed in this docker container
cmake \
    -DCMAKE_INSTALL_PREFIX=$HOME/.local \
    ..
make -j$(nproc)
make install
```

For more examples on how to build and test this code see [`.gitlab-ci.yml`](.gitlab-ci.yml).

## License

GNU General Public License v3.0 or later

See [LICENSE.md](LICENSE.md) to see the full text.

## Author

Jakob Meng
@jm1 ([GitHub.com][github-jm1], [Web][jm])

[//]: # (References)

[aeromat]: https://www.h-brs.de/de/aeromat
[cmake3-tut]: https://cmake.org/cmake/help/latest/guide/tutorial/index.html
[docker-artifacts]: https://github.com/JM1/docker-artifacts
[docker-hub-jm1337]: https://hub.docker.com/r/jm1337/
[docker-install-debian]: https://docs.docker.com/engine/install/debian/
[docker-install-mac]: https://docs.docker.com/docker-for-mac/install/
[docker-install-ubuntu]: https://docs.docker.com/engine/install/ubuntu/
[docker-install-windows]: https://docs.docker.com/docker-for-windows/install/
[docker-to-podman-transition]: https://developers.redhat.com/blog/2020/11/19/transitioning-from-docker-to-podman/
[flame]: https://www.cs.utexas.edu/~flame/web/libFLAME.html
[github-jm1]: https://github.com/jm1
[hbrs]: https://www.h-brs.de
[hbrs-gitlab-hbrs-cmake]: https://git.inf.h-brs.de/jmeng2m/hbrs-cmake/
[hbrs-gitlab-hbrs-mpl]: https://git.inf.h-brs.de/jmeng2m/hbrs-mpl/
[hbrs-gitlab-py-edamer]: https://git.inf.h-brs.de/jmeng2m/python-edamer
[hbrs-gitlab-hbrs-theta-utils]: https://git.inf.h-brs.de/jmeng2m/hbrs-theta_utils/
[hbrs-cmake]: https://github.com/JM1/hbrs-cmake/
[hbrs-mpl]: https://github.com/JM1/hbrs-mpl/
[hbrs-theta-utils]: https://github.com/JM1/hbrs-theta_utils/
[jm]: http://www.jakobmeng.de
[lapacke]: https://performance.netlib.org/lapack/
[mpi4py-ref]: https://mpi4py.readthedocs.io/
[netcdf]: https://www.unidata.ucar.edu/software/netcdf/
[podman-install]: https://podman.io/getting-started/installation
[py-edamer]: https://github.com/JM1/python-edamer
[tau]: http://tau.dlr.de/
[valgrind]: http://valgrind.org/
[wiki-cpp17]: https://en.wikipedia.org/wiki/C++17
[wiki-gzip]: https://en.wikipedia.org/wiki/Gzip
[wiki-hdf]: https://en.wikipedia.org/wiki/Hierarchical_Data_Format
[wiki-objdump]: https://en.wikipedia.org/wiki/Objdump
[wiki-perf]: https://en.wikipedia.org/wiki/Perf_(Linux)
