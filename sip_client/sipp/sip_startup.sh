#!/bin/bash
mkdir -p /root/.config/srsran
cp /mnt/srs_conf/*.conf  /root/.config/srsran
cp /mnt/conf_xml/non_em_reg.xml /sipp

case $DEFAULT_IMS_IMPI in
	alice)
		cp /mnt/conf_xml/uas_b2a.xml /sipp
		sed -i "s/UE_IMSI/$ALICE_IMSI/g" /root/.config/srsran/ue.conf
		sed -i "s/UE_OP/$ALICE_OP/g" /root/.config/srsran/ue.conf
		sed -i "s/UE_K/$ALICE_K/g" /root/.config/srsran/ue.conf
		sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /root/.config/srsran/enb.conf
		sed -i "s/ENB_IP/$SIPP_IP/g" /root/.config/srsran/enb.conf
		sed -i "s/UE_ID/$ALICE_ID/g" /sipp/non_em_reg.xml
		sed -i "s/UE_K/$ALICE_K/g" /sipp/non_em_reg.xml
		sed -i "s/UE_AMF/$ALICE_AMF/g" /sipp/non_em_reg.xml
		sed -i "s/UE_OP/$ALICE_OP/g" /sipp/non_em_reg.xml
		sed -i "s/IMS_DOMAIN/$IMS_DOMAIN/g" /sipp/non_em_reg.xml
		sed -i "s/CALLED_ID/$ALICE_ID/g" /sipp/uas_b2a.xml
		;;
	bob)
		cp /mnt/conf_xml/non_em_uac_b2a.xml /sipp
		sed -i "s/UE_IMSI/$BOB_IMSI/g" /root/.config/srsran/ue.conf
		sed -i "s/UE_OP/$BOB_OP/g" /root/.config/srsran/ue.conf
		sed -i "s/UE_K/$BOB_K/g" /root/.config/srsran/ue.conf
		sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" /root/.config/srsran/enb.conf
		sed -i "s/ENB_IP/$SIPP_II_IP/g" /root/.config/srsran/enb.conf
		sed -i "s/UE_ID/$BOB_ID/g" /sipp/non_em_reg.xml
		sed -i "s/UE_K/$BOB_K/g" /sipp/non_em_reg.xml
		sed -i "s/UE_AMF/$BOB_AMF/g" /sipp/non_em_reg.xml
		sed -i "s/UE_OP/$BOB_OP/g" /sipp/non_em_reg.xml
		sed -i "s/IMS_DOMAIN/$IMS_DOMAIN/g" /sipp/non_em_reg.xml
		;;

esac
bash
