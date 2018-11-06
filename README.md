# hbrs-cmake
[![Build Status](https://travis-ci.org/JM1/hbrs-cmake.svg?branch=master)](https://travis-ci.org/JM1/hbrs-cmake)

# How to build this code using Docker

```sh
# install Docker CE for Debian or derivatives
# please follow guide at https://docs.docker.com/install/linux/docker-ce/debian/

# docker version 18.06.0-ce or later is recommended
docker --version

# fetch and setup dockerctl
git clone --depth 1 https://gist.github.com/ab8c3beea108ea14a6b8955050f36357.git
export PATH="$PWD/ab8c3beea108ea14a6b8955050f36357/:$PATH"

# fetch docker image
docker pull jm1337/debian-testing-cpp-dev

# log into docker container
dockerctl run --login --systemd -- jm1337/debian-testing-cpp-dev



# the following commands are executed from within the docker container

# fetch, compile and install hbrs-cmake
git clone --depth 1 https://github.com/JM1/hbrs-cmake.git
cd hbrs-cmake
mkdir build && cd build/
cmake -DHBRS_CMAKE_ENABLE_TESTS=ON ..
make -j$(nproc)
ctest --output-on-failure
sudo make install
```

For more examples how to build and test code see [`.travis.yml`](https://github.com/JM1/hbrs-cmake/blob/master/.travis.yml).
