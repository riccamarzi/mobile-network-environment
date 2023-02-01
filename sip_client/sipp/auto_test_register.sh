#!/bin/bash

ip netns add ue1

#start enb, ue and ims registration in parallel
/srsRAN/build/srsenb/src/srsenb & /srsRAN/build/srsue/src/srsue & /mnt/start_ims_register.sh



