#!/bin/bash
ip tuntap add name ogstun mode tun
ip a add $TUN_SUBNET_IV dev ogstun
ip a add $TUN_SUBNET_VI dev ogstun
ip l set ogstun up
