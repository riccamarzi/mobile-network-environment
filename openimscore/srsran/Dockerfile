FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git vim wget libssl-dev pkg-config dh-autoreconf ncurses-dev lksctp-tools iproute2 build-essential cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libtool libncurses5-dev libncursesw5-dev iputils-ping
WORKDIR /
RUN git clone https://github.com/SIPp/sipp.git
WORKDIR sipp
RUN cmake . -DUSE_SSL=1
RUN make all -j `nproc`
RUN git clone https://github.com/zeromq/libzmq.git
WORKDIR libzmq
RUN ./autogen.sh
RUN ./configure
RUN make -j `nproc`
RUN make install 
RUN ldconfig
WORKDIR /
RUN git clone https://github.com/zeromq/czmq.git
WORKDIR czmq
RUN ./autogen.sh
RUN ./configure
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
RUn mkdir -p /root/.config/srsran
ADD ./mnt/*.conf /root/.config/srsran
RUN make install
WORKDIR /srsRAN/build
ADD ./srsran_conf.sh /
CMD /srsran_conf.sh
