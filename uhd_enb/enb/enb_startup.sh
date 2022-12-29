#!/bin/bash

mkdir -p /root/.config/srsran
cp /mnt/*.conf /root/.config/srsran/
sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /root/.config/srsran/enb.conf
sed -i "s/ENB_IP/$ENB_UHD_IP/g" /root/.config/srsran/enb.conf
bash
