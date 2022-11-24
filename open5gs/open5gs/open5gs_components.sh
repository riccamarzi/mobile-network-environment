case $OPEN5GS_COMPONENT in

	hss)
		cp /mnt/hss.yaml /open5gs/install/etc/open5gs
		cp /mnt/hss.conf /open5gs/install/etc/freeDiameter
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/hss.yaml
		sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /open5gs/install/etc/freeDiameter/hss.conf
		sed -i "s/HSS_IP/$HSS_IP/g" /open5gs/install/etc/freeDiameter/hss.conf
		/mnt/generate_certificates.sh
		sed -i "s/IMS_DOMAIN/$IMS_DOMAIN/g" /open5gs/install/etc/freeDiameter/hss.conf
		sed -i "s/ICSCF_IP/$KAMAILIO_ICSCF_IP/g" /open5gs/install/etc/freeDiameter/hss.conf
		sed -i "s/SCSCF_IP/$KAMAILIO_SCSCF_IP/g" /open5gs/install/etc/freeDiameter/hss.conf
		python3 /mnt/hss_sub.py
		/open5gs/install/bin/open5gs-hssd
		;;	
	mme)
		cp /mnt/mme.yaml /open5gs/install/etc/open5gs
		cp /mnt/mme.conf /open5gs/install/etc/freeDiameter
		sed -i "s/HSS_IP/$KAMAILIO_FHOSS_IP/g" /open5gs/install/etc/freeDiameter/mme.conf
		sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /open5gs/install/etc/freeDiameter/mme.conf
		sed -i "s/SGWC_IP/$OPEN5GS_SGWC_IP/g" /open5gs/install/etc/open5gs/mme.yaml
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/open5gs/mme.yaml
		sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /open5gs/install/etc/open5gs/mme.yaml
		/mnt/generate_certificates.sh
		sed -i "s/IMS_DOMAIN/$IMS_DOMAIN/g" /open5gs/install/etc/freeDiameter/mme.conf
		/open5gs/install/bin/open5gs-mmed
		;;
	sgwc)
		cp /mnt/sgwc.yaml /open5gs/install/etc/open5gs
		sed -i "s/SGWU_IP/$OPEN5GS_SGWU_IP/g" /open5gs/install/etc/open5gs/sgwc.yaml
		sed -i "s/SGWC_IP/$OPEN5GS_SGWC_IP/g" /open5gs/install/etc/open5gs/sgwc.yaml
		/open5gs/install/bin/open5gs-sgwcd
		;;
	sgwu)
		cp /mnt/sgwu.yaml /open5gs/install/etc/open5gs
		sed -i "s/SGWC_IP/$OPEN5GS_SGWC_IP/g" /open5gs/install/etc/open5gs/sgwu.yaml
		sed -i "s/SGWU_IP/$OPEN5GS_SGWU_IP/g" /open5gs/install/etc/open5gs/sgwu.yaml
		/open5gs/install/bin/open5gs-sgwud
		;;
	smf)
		cp /mnt/smf.yaml /open5gs/install/etc/open5gs
		cp /mnt/smf.conf /open5gs/install/etc/freeDiameter
		sed -i "s/PCRF_IP/$OPEN5GS_PCRF_IP/g" /open5gs/install/etc/freeDiameter/smf.conf
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/freeDiameter/smf.conf
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/smf.yaml
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/open5gs/smf.yaml
		sed -i "s/UPF_IP/$OPEN5GS_UPF_IP/g" /open5gs/install/etc/open5gs/smf.yaml
		sed -i "s/PCSCF_IP/$KAMAILIO_PCSCF_IP/g" /open5gs/install/etc/open5gs/smf.yaml
		sed -i "s/EPC_DOMAIN/$EPC_DOMAIN/g" /open5gs/install/etc/freeDiameter/smf.conf
		/mnt/generate_certificates.sh $EPC_DOMAIN
		sed -i "s/IMS_DOMAIN/$IMS_DOMAIN/g" /open5gs/install/etc/freeDiameter/smf.conf
		/open5gs/install/bin/open5gs-smfd
		;;
	amf)
		cp /mnt/amf.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/amf.yaml
		sed -i "s/AMF_IP/$OPEN5GS_AMF_IP/g" /open5gs/install/etc/open5gs/amf.yaml
		/open5gs/install/bin/open5gs-amfd
		;;
	upf)
		cp /mnt/upf.yaml /open5gs/install/etc/open5gs
		sed -i "s/UPF_IP/$OPEN5GS_UPF_IP/g" /open5gs/install/etc/open5gs/upf.yaml
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/open5gs/upf.yaml
		sed -i "s|TUN_SUBNET_IV|$TUN_SUBNET_IV|g" /open5gs/install/etc/open5gs/upf.yaml
		sed -i "s|TUN_SUBNET_VI|$TUN_SUBNET_VI|g" /open5gs/install/etc/open5gs/upf.yaml
		/mnt/upf_create_tun.sh
		iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE
		iptables -I INPUT -i ogstun -j ACCEPT
		#iptables -t nat -A POSTROUTING -s 10.46.0.0/16 ! -o ogstun2 -j MASQUERADE
		iptables -I INPUT -i ogstun2 -j ACCEPT
		/open5gs/install/bin/open5gs-upfd
		;;
	pcrf)
		cp /mnt/pcrf.yaml /open5gs/install/etc/open5gs
		cp /mnt/pcrf.conf /open5gs/install/etc/freeDiameter
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/pcrf.yaml
		sed -i "s/SMF_IP/$OPEN5GS_SMF_IP/g" /open5gs/install/etc/freeDiameter/pcrf.conf
		sed -i "s/PCSCF_IP/$OPENIMS_PCSCF_IP/g" /open5gs/install/etc/freeDiameter/pcrf.conf
		sed -i "s/PCRF_IP/$OPEN5GS_PCRF_IP/g" /open5gs/install/etc/freeDiameter/pcrf.conf
		sed -i "s/EPC_DOMAIN/$EPC_DOMAIN/g" /open5gs/install/etc/freeDiameter/pcrf.conf
		/mnt/generate_certificates.sh $EPC_DOMAIN
		sed -i "s/IMS_DOMAIN/$IMS_DOMAIN/g" /open5gs/install/etc/freeDiameter/pcrf.conf
		/open5gs/install/bin/open5gs-pcrfd
		;;
	nrf)
		cp /mnt/nrf.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/nrf.yaml
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/nrf.yaml
		/open5gs/install/bin/open5gs-nrfd
		;;
	scp)
		cp /mnt/scp.yaml /open5gs/install/etc/open5gs
		sed -i "s/NRF_IP/$OPEN5GS_NRF_IP/g" /open5gs/install/etc/open5gs/scp.yaml
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/scp.yaml
		/open5gs/install/bin/open5gs-scpd
		;;
	ausf)
		cp /mnt/ausf.yaml /open5gs/install/etc/open5gs
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/ausf.yaml
		sed -i "s/AUSF_IP/$OPEN5GS_AUSF_IP/g" /open5gs/install/etc/open5gs/ausf.yaml
		/open5gs/install/bin/open5gs-ausfd
		;;
	udm)
		cp /mnt/udm.yaml /open5gs/install/etc/open5gs
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/udm.yaml
		sed -i "s/UDM_IP/$OPEN5GS_UDM_IP/g" /open5gs/install/etc/open5gs/udm.yaml
		/open5gs/install/bin/open5gs-udmd
		;;
	nssf)
		cp /mnt/nssf.yaml /open5gs/install/etc/open5gs
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/nssf.yaml
		sed -i "s/NSSF_IP/$OPEN5GS_NSSF_IP/g" /open5gs/install/etc/open5gs/nssf.yaml
		/open5gs/install/bin/open5gs-nssfd
		;;
	pcf)
		cp /mnt/pcf.yaml /open5gs/install/etc/open5gs
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/pcf.yaml
		sed -i "s/PCF_IP/$OPEN5GS_PCF_IP/g" /open5gs/install/etc/open5gs/pcf.yaml
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/pcf.yaml
		/open5gs/install/bin/open5gs-pcfd
		;;
	bsf)
		cp /mnt/bsf.yaml /open5gs/install/etc/open5gs
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/bsf.yaml
		sed -i "s/BSF_IP/$OPEN5GS_BSF_IP/g" /open5gs/install/etc/open5gs/bsf.yaml
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/bsf.yaml
		/open5gs/install/bin/open5gs-bsfd
		;;
	udr)
		cp /mnt/udr.yaml /open5gs/install/etc/open5gs
		sed -i "s/SCP_IP/$OPEN5GS_SCP_IP/g" /open5gs/install/etc/open5gs/udr.yaml
		sed -i "s/UDR_IP/$OPEN5GS_UDR_IP/g" /open5gs/install/etc/open5gs/udr.yaml
		sed -i "s/MONGO_IP/$MONGO_IP/g" /open5gs/install/etc/open5gs/udr.yaml
		/open5gs/install/bin/open5gs-udrd
		;;
	webui)
		/mnt/webui_start.sh
		;;
esac
