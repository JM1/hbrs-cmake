# hbrs-cmake
[![Build Status](https://travis-ci.com/JM1/hbrs-cmake.svg?branch=master)](https://travis-ci.com/JM1/hbrs-cmake)

# How to build this code using Docker

## Install Docker

* On `Debian 10 (Buster)` just run `sudo apt install docker.io`
  or follow the [official install guide](https://docs.docker.com/engine/install/debian/) for Docker Engine on Debian
* On `Ubuntu 18.04 LTS (Bionic Beaver)` just run `sudo apt install docker.io` (from `bionic/universe` repositories)
  or follow the [official install guide](https://docs.docker.com/engine/install/ubuntu/) for Docker Engine on Ubuntu
* On `Windows 10` follow the [official install guide](https://docs.docker.com/docker-for-windows/install/)
  for Docker Desktop on Windows
* On `Mac` follow the [official install guide](https://docs.docker.com/docker-for-mac/install/) 
  for Docker Desktop on Mac

## Setup and Run Container

```sh
# docker version 18.06.0-ce or later is recommended
docker --version

# fetch docker image
docker pull jm1337/debian-dev-hbrs:buster

# log into docker container
docker run -ti jm1337/debian-dev-hbrs:buster
# or using a persistent home directory, e.g.
docker run -ti -v /HOST_DIR:/home/devil/ -u devil jm1337/debian-dev-hbrs:buster
# or using a persistent home directory on Windows hosts, e.g.
docker run -ti -v C:\YOUR_DIR:/home/devil/ -u devil jm1337/debian-dev-hbrs:buster
```

## Build code inside Container

Execute the following commands within the Docker Container:
```sh
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
