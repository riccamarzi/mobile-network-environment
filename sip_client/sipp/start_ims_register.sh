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

#ims registration
ip netns exec ue1 /sipp/sipp -sf /sipp/non_em_reg.xml 10.1.1.2:5060 -i $ue_ip_addr -p 3061 -m 1
