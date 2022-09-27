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
		sed -i "s/SGWC_IP/$OPEN5GS_SGWC_IP/g" /open5gs/install/etc/freeDiameter/mme.conf
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/freeDiameter/mme.conf
		sed -i "s/SMF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/freeDiameter/mme.conf
		sed -i "s/SMF_IP/$OPEN5GS_UPF_IP/g" /open5gs/install/etc/freeDiameter/mme.conf
		/open5gs/install/bin/open5gs-mmed
		;;
	sgwc)
		cp /mnt/sgwc.yaml /open5gs/install/etc/open5gs
		/open5gs/install/bin/open5gs-sgwcd
		;;
	smf)
		cp /mnt/smf.yaml /open5gs/install/etc/open5gs
		cp /mnt/smf.conf /open5gs/install/etc/freeDiameter
		sed -i "s/PCRF_IP/$OPEN5GS_PCRF_IP/g" /open5gs/install/etc/freeDiameter/smf.conf
		/open5gs/install/bin/open5gs-smfd
		;;
	pcrf)
		cp /mnt/pcrf.yaml /open5gs/install/etc/open5gs
		cp /mnt/pcrf.conf /open5gs/install/etc/freeDiameter
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/pcrf.yaml
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/freeDiameter/pcrf.conf
		/open5gs/install/bin/open5gs-pcrfd
		;;
esac
