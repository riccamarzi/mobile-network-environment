case $OPEN5GS_COMPONENT in

	hss)
		cp /mnt/hss.yaml /open5gs/install/etc/open5gs
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/hss.yaml
		/open5gs/install/bin/open5gs-hssd
		;;	
esac
