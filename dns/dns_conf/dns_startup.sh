#!/bin/bash
cp /mnt/ims.mnc001.mcc001.3gppnetwork.org /etc/bind
cp /mnt/named.conf.* /etc/bind

sed -i "s/KAMAILIO_PCSCF_IP/$KAMAILIO_PCSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/KAMAILIO_SCSCF_IP/$KAMAILIO_SCSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/KAMAILIO_ICSCF_IP/$KAMAILIO_ICSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/HSS_IP/$HSS_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org

/usr/sbin/named -c /etc/bind/named.conf -g -u bind
