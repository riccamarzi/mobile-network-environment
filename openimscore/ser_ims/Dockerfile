FROM icomputer7/ancient-ubuntu-docker:jaunty
#FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget git screen libncurses5-dev libncursesw5-dev libcurl4-gnutls-dev mysql-server libssl-dev bison curl debhelper cdbs lintian build-essential fakeroot devscripts pbuilder dh-make debootstrap dpatch flex libxml2-dev libmysqlclient15-dev ant docbook-to-man ipsec-tools subversion
#RUN apt update
#RUN apt install -y git wget libmysqlclient-dev libpq-dev uuid-dev iproute2 dh-make dpatch debootstrap devscripts pbuilder libexpat1-dev libxml2-dev cmake gcc build-essential flex bison
RUN mkdir -p /opt/OpenIMSCore
WORKDIR /opt/OpenIMSCore
RUN mkdir ser_ims && svn checkout http://svn.code.sf.net/p/openimscore/code/ser_ims/trunk ser_ims
WORKDIR ser_ims
#RUN git clone https://github.com/cp-george/OpenIMSCore.git
#WORKDIR OpenIMSCore/ser_ims
RUN make install-libs all
#ADD ./sipp-3.0.src /sipp-3.0.src
#ENV PATH="${PATH}:/sipp-3.0.src"
#WORKDIR /sipp-3.0.src
#RUN make ossl
ADD ./openims_components.sh /
RUN chmod +x /openims_components.sh
CMD /openims_components.sh
