FROM ubuntu:bionic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install python3-pip python3-setuptools python3-wheel ninja-build build-essential flex bison git libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev libnghttp2-dev libmicrohttpd-dev libcurl4-gnutls-dev libnghttp2-dev libtins-dev libtalloc-dev meson -y
RUN git clone https://github.com/open5gs/open5gs
WORKDIR open5gs
RUN meson build --prefix=$(pwd)/install
RUN ninja -C build
WORKDIR build 
RUN ninja install
WORKDIR ..
ADD open5gs_components.sh /
RUN chmod +x /open5gs_components.sh
CMD /open5gs_components.sh
