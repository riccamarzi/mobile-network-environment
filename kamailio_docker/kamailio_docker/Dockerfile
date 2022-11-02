FROM ubuntu:bionic
COPY modules.lst .
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y iputils-ping tcpdump host screen make libssl-dev ipsec-tools vim iproute2 mysql-server ntp ntpdate git-core dkms gcc flex bison libmysqlclient-dev libcurl4-openssl-dev libxml2-dev libpcre3-dev bash-completion g++ autoconf rtpproxy libmnl-dev libsctp-dev libradcli-dev libradcli4
RUN mkdir -p /usr/local/src
WORKDIR /usr/local/src
RUN git clone https://github.com/herlesupreeth/kamailio 
WORKDIR /usr/local/src/kamailio
RUN make cfg
WORKDIR /usr/local/src/kamailio/src
RUN cat /modules.lst > ./modules.lst
RUN rm /modules.lst
RUN make -j`nproc` Q=0 all | tee make_all.txt
RUN make install | tee make_install.txt
RUN ldconfig
RUN sed -i 's/# DBENGINE=MYSQL/DBENGINE=MYSQL/' /usr/local/etc/kamailio/kamctlrc
RUN sed -i 's/# SIP_DOMAIN=kamailio.org/SIP_DOMAIN=ims.mnc001.mcc001.3gppnetwork.org/' /usr/local/etc/kamailio/kamctlrc
RUN sed -i 's/# DBROOTUSER="root"/DBROOTUSER="root"/' /usr/local/etc/kamailio/kamctlrc
RUN sed -i 's/# DBROOTPW="dbrootpw"/DBROOTPW="root"/' /usr/local/etc/kamailio/kamctlrc
RUN sed -i 's/# DBHOST=localhost/DBHOST=${MYSQL_IP}/' /usr/local/etc/kamailio/kamctlrc
RUN mkdir -p /var/run/kamailio
RUN adduser --quiet --system --group --disabled-password --shell /bin/false --gecos "Kamailio" --home /var/run/kamailio kamailio
RUN chown kamailio:kamailio /var/run/kamailio
RUN sed -i 's/# INSTALL_EXTRA_TABLES=ask/INSTALL_EXTRA_TABLES=yes/' /usr/local/etc/kamailio/kamctlrc
RUN sed -i 's/# INSTALL_DBUID_TABLES=ask/INSTALL_DBUID_TABLES=yes/' /usr/local/etc/kamailio/kamctlrc
RUN sed -i 's/# INSTALL_PRESENCE_TABLES=ask/INSTALL_PRESENCE_TABLES=yes/' /usr/local/etc/kamailio/kamctlrc
WORKDIR /
COPY kamailio_components.sh /
RUN chmod +x ./kamailio_components.sh
CMD ./kamailio_components.sh
