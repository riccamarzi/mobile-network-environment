case $KAMAILIO_COMPONENT in

	scscf)
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD -e "CREATE DATABASE scscf"
		cd /usr/local/src/kamailio/utils/kamctl/mysql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD scscf < standard-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD scscf < presence-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD scscf < ims_usrloc_scscf-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD scscf < ims_dialog-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD scscf < ims_charging-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD scscf < /mnt/scscf_permission.sql 
		mkdir -p /var/run/kamailio_scscf
		cp -r /mnt/scscf_config /etc/kamailio_scscf
		sed -i "s/SCSCF_IP/$KAMAILIO_SCSCF_IP/g" /etc/kamailio_scscf/scscf.*
		sed -i "s/SCSCF_IP/$KAMAILIO_SCSCF_IP/g" /etc/kamailio_scscf/kamailio_scscf.cfg
		sed -i "s/KAMAILIO_MYSQL_IP/$KAMAILIO_MYSQL_IP/g" /etc/kamailio_scscf/scscf.cfg
		cp /mnt/scscf_config/resolv.conf /etc
		kamailio -f /etc/kamailio_scscf/kamailio_scscf.cfg -P /kamailio_scscf.pid -DD -E -e
		;;
	icscf)
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD -e "CREATE DATABASE icscf"
		cd /usr/local/src/kamailio/misc/examples/ims/icscf
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD icscf < icscf.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD icscf < /mnt/icscf_specific.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD icscf < /mnt/icscf_permission.sql
		mkdir -p /var/run/kamailio_icscf
		cp -r /mnt/icscf_config /etc/kamailio_icscf
		sed -i "s/ICSCF_IP/$KAMAILIO_ICSCF_IP/g" /etc/kamailio_icscf/icscf.*
		sed -i "s/ICSCF_IP/$KAMAILIO_ICSCF_IP/g" /etc/kamailio_icscf/kamailio_icscf.cfg
		sed -i "s/KAMAILIO_MYSQL_IP/$KAMAILIO_MYSQL_IP/g" /etc/kamailio_icscf/icscf.cfg
		cp /mnt/icscf_config/resolv.conf /etc
		kamailio -f /etc/kamailio_icscf/kamailio_icscf.cfg -P /kamailio_icscf.pid -DD -E -e
		;;
	pcscf)
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD -e "CREATE DATABASE pcscf"
		cd /usr/local/src/kamailio/utils/kamctl/mysql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD pcscf < standard-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD pcscf < presence-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD pcscf < ims_usrloc_pcscf-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD pcscf < ims_dialog-create.sql
		mysql -u root -h $KAMAILIO_MYSQL_IP -p$KAMAILIO_MYSQL_PWD pcscf < /mnt/pcscf_permission.sql
		mkdir -p /var/run/kamailio_pcscf
		cp -r /mnt/pcscf_config /etc/kamailio_pcscf
		sed -i "s/PCSCF_IP/$KAMAILIO_PCSCF_IP/g" /etc/kamailio_pcscf/pcscf.*
		sed -i "s/PCSCF_IP/$KAMAILIO_PCSCF_IP/g" /etc/kamailio_pcscf/kamailio_pcscf.cfg
		sed -i "s/KAMAILIO_MYSQL_IP/$KAMAILIO_MYSQL_IP/g" /etc/kamailio_pcscf/pcscf.cfg 
		sed -i "s/KAMAILIO_RTP_IP/$KAMAILIO_RTP_IP/g" /etc/kamailio_pcscf/kamailio_pcscf.cfg
		cp /mnt/pcscf_config/resolv.conf /etc
		kamailio -f /etc/kamailio_pcscf/kamailio_pcscf.cfg -P /kamailio_pcscf.pid -DD -E -e
		;;
esac
