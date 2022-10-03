FROM icomputer7/ancient-ubuntu-docker:jaunty
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 
RUN apt-get install -y wget libcurl4-gnutls-dev bison curl debhelper cdbs lintian build-essential fakeroot devscripts pbuilder dh-make debootstrap dpatch flex libxml2-dev libmysqlclient15-dev ant docbook-to-man ipsec-tools subversion
RUN mkdir -p /opt/OpenIMSCore
WORKDIR /opt/OpenIMSCore
RUN mkdir ser_ims 
RUN svn checkout http://svn.code.sf.net/p/openimscore/code/ser_ims/branches/12_em_services ser_ims
WORKDIR ser_ims
RUN make install-libs all
ADD ./openims_components.sh /
RUN chmod +x /openims_components.sh
CMD /openims_components.sh
