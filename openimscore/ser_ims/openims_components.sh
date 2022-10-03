case $OPENIMS_COMPONENT in
	pcscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/pcscf.sh /opt/OpenIMSCore
		cp /mnt/pcscf.* /opt/OpenIMSCore
		/opt/OpenIMSCore/pcscf.sh
		;;
	scscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/scscf.sh /opt/OpenIMSCore
		cp /mnt/scscf.* /opt/OpenIMSCore
		/opt/OpenIMSCore/scscf.sh
		;;
	icscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/icscf.sh /opt/OpenIMSCore
		cp /mnt/icscf.* /opt/OpenIMSCore
		cp /mnt/icscf.sql /opt/OpenIMSCore/ser_ims/cfg
		sed -i "s/MYSQL_IP/$OPENIMS_MYSQL_IP/g" /opt/OpenIMSCore/icscf.cfg
		mysql -u root -p$OPENIMS_MYSQL_PWD -h $OPENIMS_MYSQL_IP < /opt/OpenIMSCore/icscf.sql
		/opt/OpenIMSCore/icscf.sh
		;;
esac
