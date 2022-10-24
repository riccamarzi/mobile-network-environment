#!/bin/bash
cp /mnt/ims.mnc001.mcc001.3gppnetwork.org /etc/bind
cp /mnt/epc.mnc001.mcc001.3gppnetwork.org /etc/bind
cp /mnt/named.conf.* /etc/bind

sed -i "s/KAMAILIO_PCSCF_IP/$KAMAILIO_PCSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/KAMAILIO_SCSCF_IP/$KAMAILIO_SCSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/KAMAILIO_ICSCF_IP/$KAMAILIO_ICSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/OPEN5GS_SMF_IP/$OPEN5GS_SMF_IP/g" /etc/bind/epc.mnc001.mcc001.3gppnetwork.org
sed -i "s/OPEN5GS_PCRF_IP/$OPEN5GS_PCRF_IP/g" /etc/bind/epc.mnc001.mcc001.3gppnetwork.org
sed -i "s/HSS_IP/$KAMAILIO_FHOSS_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org

/usr/sbin/named -c /etc/bind/named.conf -g -u bind
