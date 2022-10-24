FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y git vim libssl-dev pkg-config dh-autoreconf ncurses-dev lksctp-tools iproute2 build-essential cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libtool libncurses5-dev libncursesw5-dev iputils-ping
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
ADD sip_startup.sh /
RUN chmod +x /sip_startup.sh 
CMD /sip_startup.sh
#se servisse sipexer
#RUN wget https://dl.google.com/go/go1.17.linux-amd64.tar.gz
#RUN tar -C /usr/local/ -xzf go1.17.linux-amd64.tar.gz
#ENV PATH=$PATH:/usr/local/go/bin
#RUN git clone https://github.com/miconda/sipexer
#WORKDIR sipexer
#RUN go get ./...
#RUN go build .
