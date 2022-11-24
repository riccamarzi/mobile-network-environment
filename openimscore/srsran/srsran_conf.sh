#!/bin/bash
sed -i "s/MME_IP/$OPEN5GS_MME_IP/g" ~/.config/srsran/enb.conf

case $RAN_COMPONENT in

	ran)
		sed -i "s/RAN_IP/$OPENIMS_RAN_IP/g" ~/.config/srsran/enb.conf
		cp /mnt/alice.conf ~/.config/srsran/ue.conf
		cp /mnt/non_em_reg_alice.xml /sipp
		cp /mnt/uas_b2a.xml /sipp
		;;
	ran2)
		sed -i "s/RAN_IP/$OPENIMS_RAN2_IP/g" ~/.config/srsran/enb.conf
		cp /mnt/bob.conf ~/.config/srsran/ue.conf
		cp /mnt/non_em_reg_bob.xml /sipp
		cp /mnt/non_em_uac_b2a.xml /sipp
		;;
esac
bash
