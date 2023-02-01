#!/bin/bash

#check if tun_srsue exists
while true; do
    ip netns exec ue1 ip a show dev tun_srsue &> /dev/null
    if [ $? -eq 1 ]; then
        sleep 2  # network not yet up
    else
	ip netns exec ue1 ip r add default via 10.46.0.1
        break   # network up
    fi
done

ue_ip_addr=$(ip netns exec ue1 ip a show dev tun_srsue | awk '/inet/ {print $2}' | awk -F / '{print $1}')

#discover pcscf active
ip netns exec ue1 ping $KAMAILIO_PCSCF_IP -c 1 &> /dev/null
if [ $? -eq 0 ]; then
	pcscf_ip_addr=$KAMAILIO_PCSCF_IP
else
	pcscf_ip_addr=$OPENIMS_PCSCF_IP
fi

#ims registration
ip netns exec ue1 /sipp/sipp -sf /sipp/non_em_reg.xml $pcscf_ip_addr:5060 -i $ue_ip_addr -p 5060 -m 1
