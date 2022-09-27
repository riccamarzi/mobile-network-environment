case $OPEN5GS_COMPONENT in

	hss)
		cp /mnt/hss.yaml /open5gs/install/etc/open5gs
		cp /mnt/hss.conf /open5gs/install/etc/freeDiameter
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/hss.yaml
		sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /open5gs/install/etc/freeDiameter/hss.conf
		/open5gs/install/bin/open5gs-hssd
		;;	
	mme)
		cp /mnt/mme.yaml /open5gs/install/etc/open5gs
		cp /mnt/mme.conf /open5gs/install/etc/freeDiameter
		sed -i "s/HSS_IP/$HSS_IP/g" /open5gs/install/etc/freeDiameter/mme.conf
		/open5gs/install/bin/open5gs-mmed
		;;
	sgwc)
		cp /mnt/sgwc.yaml /open5gs/install/etc/open5gs
		/open5gs/install/bin/open5gs-sgwcd
		;;
esac
