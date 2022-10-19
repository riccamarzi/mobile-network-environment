#!/bin/bash
cp /mnt/named.conf.local /etc/bind
cp /mnt/named.conf.options /etc/bind
cp /mnt/open-ims.test /etc/bind
sed -i "s/PCSCF_IP/$OPENIMS_PCSCF_IP/g" /etc/bind/open-ims.test
sed -i "s/ICSCF_IP/$OPENIMS_ICSCF_IP/g" /etc/bind/open-ims.test
sed -i "s/SIPP_IP/$OPENIMS_SIPP_IP/g" /etc/bind/open-ims.test
sed -i "s/SCSCF_IP/$OPENIMS_SCSCF_IP/g" /etc/bind/open-ims.test
sed -i "s/ECSCF_IP/$OPENIMS_ECSCF_IP/g" /etc/bind/open-ims.test
sed -i "s/FHOSS_IP/$OPENIMS_FHOSS_IP/g" /etc/bind/open-ims.test
sed -i "s/LRF_IP/$OPENIMS_LRF_IP/g" /etc/bind/open-ims.test