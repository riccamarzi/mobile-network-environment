FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git vim libssl-dev pkg-config dh-autoreconf ncurses-dev lksctp-tools iproute2 build-essential cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libtool libncurses5-dev libncursesw5-dev iputils-ping
RUN apt clean && apt autoclean && apt autoremove
WORKDIR /
RUN git clone https://github.com/SIPp/sipp.git
WORKDIR sipp
RUN git checkout 542be7a00dbd83250dc26ad358e899dcbf8d8f48
RUN cmake . -DUSE_SSL=1
RUN make all -j `nproc`
WORKDIR /
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
ADD sip_startup.sh /
RUN chmod +x /sip_startup.sh 
CMD /sip_startup.sh
