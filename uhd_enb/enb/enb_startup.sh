#!/bin/bash

mkdir -p /root/.config/srsran
cp /mnt/*.conf /root/.config/srsran/
sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /root/.config/srsran/enb.conf
case $ENB_COMPONENT in
	enb1)
		sed -i "s/ENB_IP/$ENB_UHD_IP/g" /root/.config/srsran/enb.conf
		;;
	enb2)
		sed -i "s/ENB_IP/$ENB_II_UHD_IP/g" /root/.config/srsran/enb.conf
		;;
esac
bash
