FROM icomputer7/ancient-ubuntu-docker:jaunty
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget git screen libncurses5-dev libncursesw5-dev libcurl4-gnutls-dev mysql-server libssl-dev bison curl debhelper cdbs lintian build-essential fakeroot devscripts pbuilder dh-make debootstrap dpatch flex libxml2-dev libmysqlclient15-dev ant docbook-to-man ipsec-tools subversion
RUN mkdir -p /opt/OpenIMSCore
WORKDIR /opt/OpenIMSCore
RUN mkdir ser_ims && svn checkout http://svn.code.sf.net/p/openimscore/code/ser_ims/trunk ser_ims
WORKDIR ser_ims
RUN make install-libs all
ADD ./openims_components.sh /
RUN chmod +x /openims_components.sh
CMD /openims_components.sh
