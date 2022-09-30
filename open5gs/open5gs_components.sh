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
		sed -i "s/SGWC_IP/$OPEN5GS_SGWC_IP/g" /open5gs/install/etc/open5gs/mme.yaml
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/open5gs/mme.yaml
		/open5gs/install/bin/open5gs-mmed
		;;
	sgwc)
		cp /mnt/sgwc.yaml /open5gs/install/etc/open5gs
		sed -i "s/SGWU_IP/$OPEN5GS_SGWU_IP/g" /open5gs/install/etc/open5gs/sgwc.yaml
		/open5gs/install/bin/open5gs-sgwcd
		;;
	sgwu)
		cp /mnt/sgwu.yaml /open5gs/install/etc/open5gs
		sed -i "s/SGWC_IP/$OPEN5GS_SGWC_IP/g" /open5gs/install/etc/open5gs/sgwu.yaml
		/open5gs/install/bin/open5gs-sgwud
		;;
	smf)
		cp /mnt/smf.yaml /open5gs/install/etc/open5gs
		cp /mnt/smf.conf /open5gs/install/etc/freeDiameter
		sed -i "s/PCRF_IP/$OPEN5GS_PCRF_IP/g" /open5gs/install/etc/freeDiameter/smf.conf
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/smf.yaml
		sed -i "s/UPF_IP/$OPEN5GS_UPF_IP/g" /open5gs/install/etc/open5gs/smf.yaml
		/open5gs/install/bin/open5gs-smfd
		;;
	amf)
		cp /mnt/amf.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/amf.yaml
		/open5gs/install/bin/open5gs-amfd
		;;
	upf)
		cp /mnt/upf.yaml /open5gs/install/etc/open5gs
		sed -i "s|TUN_SUBNET_IV|$TUN_SUBNET_IV|g" /open5gs/install/etc/open5gs/upf.yaml
		sed -i "s|TUN_SUBNET_VI|$TUN_SUBNET_VI|g" /open5gs/install/etc/open5gs/upf.yaml
		/mnt/upf_create_tun.sh
		/open5gs/install/bin/open5gs-upfd
		#bash
		;;
	pcrf)
		cp /mnt/pcrf.yaml /open5gs/install/etc/open5gs
		cp /mnt/pcrf.conf /open5gs/install/etc/freeDiameter
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/pcrf.yaml
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/freeDiameter/pcrf.conf
		/open5gs/install/bin/open5gs-pcrfd
		;;
	nrf)
		cp /mnt/nrf.yaml /open5gs/install/etc/open5gs
		/open5gs/install/bin/open5gs-nrfd
		;;
	ausf)
		cp /mnt/ausf.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/ausf.yaml
		/open5gs/install/bin/open5gs-ausfd
		;;
	udm)
		cp /mnt/udm.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/udm.yaml
		/open5gs/install/bin/open5gs-udmd
		;;
	nssf)
		cp /mnt/nssf.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/nssf.yaml
		/open5gs/install/bin/open5gs-nssfd
		;;
	pcf)
		cp /mnt/pcf.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/pcf.yaml
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/pcf.yaml
		/open5gs/install/bin/open5gs-pcfd
		;;
	bsf)
		cp /mnt/bsf.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/bsf.yaml
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/bsf.yaml
		/open5gs/install/bin/open5gs-bsfd
		;;
	udr)
		cp /mnt/udr.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/udr.yaml
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/udr.yaml
		/open5gs/install/bin/open5gs-udrd
		;;
esac
