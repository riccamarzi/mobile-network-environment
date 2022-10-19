#FROM icomputer7/ancient-ubuntu-docker:jaunty
FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git iproute2 libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev cmake pkg-config m4 libtool autoconf automake iputils-ping dh-make build-essential libncurses5-dev libncursesw5-dev openssl libssl-dev
ADD ./sipp-3.0.src /sipp-3.0.src
WORKDIR sipp-3.0.src
#RUN make ossl
ENV PATH="${PATH}:/sipp-3.0.src"
WORKDIR /
#RUN git clone https://github.com/zeromq/libzmq.git
ADD libzmq /libzmq
WORKDIR libzmq
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install 
RUN ldconfig
WORKDIR /
RUN git clone https://github.com/zeromq/czmq.git
WORKDIR czmq
RUN ./autogen.sh
RUN ./configure
RUN make 
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
#RUN wget https://dl.google.com/go/go1.17.linux-amd64.tar.gz
#RUN tar -C /usr/local/ -xzf go1.17.linux-amd64.tar.gz
#ENV PATH=$PATH:/usr/local/go/bin
#RUN git clone https://github.com/miconda/sipexer
#WORKDIR sipexer
#RUN go get ./...
#RUN go build .
