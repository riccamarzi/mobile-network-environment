#!/bin/bash
cp /mnt/ims.mnc001.mcc001.3gppnetwork.org /etc/bind
cp /mnt/ims.openims.mnc001.mcc001.3gppnetwork.org /etc/bind
cp /mnt/epc.mnc001.mcc001.3gppnetwork.org /etc/bind
cp /mnt/named.conf.* /etc/bind

sed -i "s/KAMAILIO_PCSCF_IP/$KAMAILIO_PCSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/KAMAILIO_SCSCF_IP/$KAMAILIO_SCSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/KAMAILIO_ICSCF_IP/$KAMAILIO_ICSCF_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/ICSCF_IP/$OPENIMS_ICSCF_IP/g" /etc/bind/ims.openims.mnc001.mcc001.3gppnetwork.org
sed -i "s/PCSCF_IP/$OPENIMS_PCSCF_IP/g" /etc/bind/ims.openims.mnc001.mcc001.3gppnetwork.org
sed -i "s/ECSCF_IP/$OPENIMS_ECSCF_IP/g" /etc/bind/ims.openims.mnc001.mcc001.3gppnetwork.org
sed -i "s/SCSCF_IP/$OPENIMS_SCSCF_IP/g" /etc/bind/ims.openims.mnc001.mcc001.3gppnetwork.org
sed -i "s/LRF_IP/$OPENIMS_LRF_IP/g" /etc/bind/ims.openims.mnc001.mcc001.3gppnetwork.org
sed -i "s/OPEN5GS_SMF_IP/$OPEN5GS_SMF_IP/g" /etc/bind/epc.mnc001.mcc001.3gppnetwork.org
sed -i "s/OPEN5GS_PCRF_IP/$OPEN5GS_PCRF_IP/g" /etc/bind/epc.mnc001.mcc001.3gppnetwork.org
sed -i "s/HSS_IP/$KAMAILIO_FHOSS_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org
sed -i "s/FHOSS_IP/$KAMAILIO_FHOSS_IP/g" /etc/bind/ims.mnc001.mcc001.3gppnetwork.org

/usr/sbin/named -c /etc/bind/named.conf -g -u bind
