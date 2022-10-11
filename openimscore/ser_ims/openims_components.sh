case $OPENIMS_COMPONENT in
	pcscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/pcscf.sh /opt/OpenIMSCore
		cp /mnt/pcscf.* /opt/OpenIMSCore
		cp /mnt/resolv.conf /etc/resolv.conf
		sed -i "s/PCSCF_IP/$OPENIMS_PCSCF_IP/g" /opt/OpenIMSCore/pcscf.cfg
		/opt/OpenIMSCore/pcscf.sh
		;;
	scscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/scscf.sh /opt/OpenIMSCore
		cp /mnt/scscf.* /opt/OpenIMSCore
		cp /mnt/resolv.conf /etc/resolv.conf
		sed -i "s/SCSCF_IP/$OPENIMS_SCSCF_IP/g" /opt/OpenIMSCore/scscf.cfg
		sed -i "s/PCSCF_IP/$OPENIMS_PCSCF_IP/g" /opt/OpenIMSCore/scscf.cfg
		/opt/OpenIMSCore/scscf.sh
		;;
	icscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/icscf.sh /opt/OpenIMSCore
		cp /mnt/icscf.* /opt/OpenIMSCore
		cp /mnt/icscf.sql /opt/OpenIMSCore/ser_ims/cfg
		sed -i "s/MYSQL_IP/$OPENIMS_MYSQL_IP/g" /opt/OpenIMSCore/icscf.cfg
		mysql -u root -p$OPENIMS_MYSQL_PWD -h $OPENIMS_MYSQL_IP < /opt/OpenIMSCore/icscf.sql
		cp /mnt/resolv.conf /etc/resolv.conf
		sed -i "s/ICSCF_IP/$OPENIMS_ICSCF_IP/g" /opt/OpenIMSCore/icscf.cfg
		/opt/OpenIMSCore/icscf.sh
		;;
	ecscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/ecscf.sh /opt/OpenIMSCore
		cp /mnt/ecscf.* /opt/OpenIMSCore
		cp /mnt/resolv.conf /etc/resolv.conf
		sed -i "s/ECSCF_IP/$OPENIMS_ECSCF_IP/g" /opt/OpenIMSCore/ecscf.cfg
		/opt/OpenIMSCore/ecscf.sh
		;;
	lrf)
		cp /opt/OpenIMSCore/ser_ims/cfg/lrf.sh /opt/OpenIMSCore
		cp /mnt/lrf.cfg /opt/OpenIMSCore
		cp /mnt/resolv.conf /etc/resolv.conf
		sed -i "s/LRF_IP/$OPENIMS_LRF_IP/g" /opt/OpenIMSCore/lrf.cfg
		/opt/OpenIMSCore/lrf.sh
		;;
	sipp)
		cp /mnt/add-imscore-user_newdb.sh /opt/OpenIMSCore/ser_ims/cfg
		cp /mnt/*.sql /opt/OpenIMSCore
		chmod +x /opt/OpenIMSCore/ser_ims/cfg/add-imscore-user_newdb.sh
		sleep 10
		/opt/OpenIMSCore/ser_ims/cfg/add-imscore-user_newdb.sh -u psap_nj -t tel:112 -a
		sed -i "s/open-ims.test/$OPENIMS_IMS_DOMAIN/g" /opt/OpenIMSCore/ser_ims/test/emerg_serv/*.xml
		cp /mnt/resolv.conf /etc/resolv.conf
		bash
		;;
esac
