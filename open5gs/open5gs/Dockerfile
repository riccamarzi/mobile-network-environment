FROM ubuntu:bionic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y curl python3-pip iptables python3-setuptools iproute2 ifupdown net-tools vim netbase iputils-ping python3-wheel ninja-build build-essential flex bison git libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev libnghttp2-dev libmicrohttpd-dev libcurl4-gnutls-dev libnghttp2-dev libtins-dev libtalloc-dev meson  
RUN git clone https://github.com/open5gs/open5gs
WORKDIR open5gs
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install nodejs
RUN apt clean && apt autoclean && apt autoremove
WORKDIR webui
RUN npm ci --no-optional
WORKDIR ..
RUN meson build --prefix=$(pwd)/install
RUN ninja -C build
WORKDIR build 
RUN ninja install
WORKDIR ..
RUN pip3 install pymongo
ADD open5gs_components.sh /
CMD /open5gs_components.sh
