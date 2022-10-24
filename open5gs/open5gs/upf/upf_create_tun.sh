#!/bin/bash
ip tuntap add name ogstun mode tun
ip a add $TUN_SUBNET_IV dev ogstun
ip a add $TUN_SUBNET_VI dev ogstun
ip l set ogstun up
ip tuntap add name ogstun2 mode tun
ip a add 10.46.0.1/16 dev ogstun2
ip l set ogstun2 up
