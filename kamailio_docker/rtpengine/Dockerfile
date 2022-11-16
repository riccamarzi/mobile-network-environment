FROM ubuntu:focal
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive TZ="Europe/Rome" apt install -y tzdata
ENV DEB_BUILD_PROFILES="pkg.ngcp-rtpengine.nobcg729"
RUN apt install -y git
RUN git clone https://github.com/sipwise/rtpengine
WORKDIR rtpengine
RUN git checkout mr9.4.1
RUN apt install -y dpkg-dev debhelper libxtables-dev default-libmysqlclient-dev gperf libavcodec-dev libavfilter-dev libavformat-dev \
					libavutil-dev libbencode-perl libcrypt-openssl-rsa-perl libcrypt-rijndael-perl libdigest-crc-perl libdigest-hmac-perl \
					libevent-dev libhiredis-dev libio-multiplex-perl libio-socket-inet6-perl libiptc-dev libjson-glib-dev libnet-interface-perl \
					libpcap0.8-dev libpcre3-dev libsocket6-perl libspandsp-dev libssl-dev libswresample-dev libsystemd-dev libxmlrpc-core-c3-dev \
					markdown dkms module-assistant keyutils libnfsidmap2 nfs-common rpcbind libglib2.0-dev zlib1g-dev libavcodec-extra \
					libcurl4-openssl-dev netcat-openbsd netcat iptables iproute2 net-tools iputils-ping libconfig-tiny-perl libwebsockets-dev 
RUN dpkg-checkbuilddeps
RUN dpkg-buildpackage -b -uc -us
WORKDIR ..
RUN dpkg -i *.deb
RUN ldconfig
#RUN cp /etc/rtpengine/rtpengine.sample.conf /etc/rtpengine/rtpengine.conf
CMD /mnt/rtp_startup.sh
