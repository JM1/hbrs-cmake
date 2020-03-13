# hbrs-cmake
[![Build Status](https://travis-ci.com/JM1/hbrs-cmake.svg?branch=master)](https://travis-ci.com/JM1/hbrs-cmake)

# How to build this code using Docker

```sh
# install Docker CE for Debian or derivatives
# please follow guide at https://docs.docker.com/install/linux/docker-ce/debian/

# docker version 18.06.0-ce or later is recommended
docker --version

# fetch docker image
docker pull jm1337/debian-dev-hbrs:buster

# log into docker container
docker run -ti jm1337/debian-dev-hbrs:buster
# or for a persistent home directory, e.g.
docker run -ti -v /HOST_DIR:/home/devil/ -u devil jm1337/debian-dev-hbrs:buster



# the following commands are executed from within the docker container

# choose a compiler
export CC=clang-7
export CXX=clang++-7
# or
#export CC=gcc-8
#export CXX=g++-8

# fetch, compile and install hbrs-cmake
git clone --depth 1 https://github.com/JM1/hbrs-cmake.git
cd hbrs-cmake
mkdir build && cd build/
# install to non-system directory because sudo is not allowed in this docker container
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local ..
make -j$(nproc)
make install
```

For more examples how to build and test code see [`.travis.yml`](https://github.com/JM1/hbrs-cmake/blob/master/.travis.yml).
