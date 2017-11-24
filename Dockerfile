FROM ubuntu:16.04

MAINTAINER Adam Steer <adam@synth3d.co>

RUN apt-get update && apt-get install  -y --fix-missing --no-install-recommends\
    build-essential \
    ca-certificates \
    cmake \
    git \
    libboost-all-dev

RUN git clone https://github.com/LASzip/LASzip.git; \
    cd LASzip; \
    mkdir build && cd build; \
    cmake .. \
        -DCMAKE_BUILD_TYPE="Release" \
        -DCMAKE_INSTALL_PREFIX=/usr; \
    make && make install && ldconfig; \
    cd /; \
    rm -rf LASzip; \
    git clone https://github.com/potree/PotreeConverter.git; \
    cd PotreeConverter && mkdir build && cd build; \
    cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DLASZIP_INCLUDE_DIRS=/usr/include/laszip \
        -DLASZIP_LIBRARY=/usr/lib/liblaszip.so \
        -DCMAKE_INSTALL_PREFIX=/usr; \
    make && make install && ldconfig; \
    cd /; \
    rm -rf PotreeConverter

CMD PotreeConverter
