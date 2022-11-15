FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y build-essential cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev autoconf automake ccache cpufrequtils doxygen ethtool \
g++ git inetutils-tools libboost-all-dev libncurses5 libncurses5-dev libusb-1.0-0 libusb-1.0-0-dev \
libusb-dev python3-dev python3-mako python3-numpy python3-requests python3-scipy python3-setuptools \
python3-ruamel.yaml
RUN git clone https://github.com/EttusResearch/uhd.git
WORKDIR uhd/host
RUN mkdir build 
WORKDIR build
RUN cmake -DLIB_SUFFIX=64 ../
RUN make -j `nproc`
RUN make install
RUN ldconfig
WORKDIR /
RUN git clone https://github.com/srsRAN/srsRAN.git
WORKDIR srsRAN
RUN mkdir build
WORKDIR build 
RUN cmake ../
RUN make -j `nproc`
RUN make install 
RUN srsran_install_configs.sh user
CMD bash
