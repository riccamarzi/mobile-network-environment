#!/bin/bash

openssl req -new -batch -x509 -days 365 -nodes -newkey rsa:1024 -out $OPEN5GS_COMPONENT.cert.pem -keyout $OPEN5GS_COMPONENT.key.pem -subj /CN=$OPEN5GS_COMPONENT.$EPC_DOMAIN

openssl dhparam -out $OPEN5GS_COMPONENT.dh.pem 1024 

mv $OPEN5GS_COMPONENT.cert.pem /open5gs/install/etc/freeDiameter
mv $OPEN5GS_COMPONENT.key.pem /open5gs/install/etc/freeDiameter
mv $OPEN5GS_COMPONENT.dh.pem /open5gs/install/etc/freeDiameter
