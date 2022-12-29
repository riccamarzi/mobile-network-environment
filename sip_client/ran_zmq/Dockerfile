FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y libzmq3-dev build-essential cmake libfftw3-dev vim libtool libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev git
RUN git clone https://github.com/zeromq/libzmq.git
WORKDIR libzmq
RUN ./autogen.sh
RUN ./configure
RUN make -j `nproc` && make install && ldconfig
WORKDIR /
RUN git clone https://github.com/zeromq/czmq.git
WORKDIR czmq
RUN ./autogen.sh
RUN ./configure
RUN make -j `nproc` && make install && ldconfig
WORKDIR /
RUN git clone https://github.com/srsRAN/srsRAN.git
WORKDIR srsRAN 
RUN mkdir build
WORKDIR build
RUN cmake ../ && make -j `nproc`
ADD ./srsran_startup.sh /
CMD /srsran_startup.sh
